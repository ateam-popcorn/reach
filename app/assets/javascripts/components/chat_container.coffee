Vue.component 'survay-chat-container',
  template: '#survay-chat-container'
  props: ['roomToken', 'meetingId']

  events:
    'hook:created': ->
      @connections = {}

      ws = new WebSocketRails("#{location.host}/websocket")
      channel = ws.subscribe "meetings_#{@meetingId}", =>
        channel.bind 'member_joined', @memberJoined

        config = { audio: true, video: true }
        navigator.getUserMedia(config, @mediaGetSucceeded, @mediaGetFailed)


  methods:
    joinRoom: (meetingId) ->
      @$peer = new Peer(key: 'y7i7yij7g2pgb9')
      @$peer.on 'open', (id) =>
        console.log "my peer id: #{id}"
        $.post("/meetings/#{meetingId}/room/member", peer_id: id)

      @$peer.on 'call', @callReceived

    memberJoined: (data) ->
      return if @$peer.id == data.peer_id
      console.log "memberJoined: ", data
      console.log "#{data.user.email}'s peer id: #{data.peer_id}"

      @$peer.call(data.peer_id, @$localStream)
      @connections[@$peer.id] = data.peer_id

    callReceived: (call) ->
      console.log 'callReceived', call
      @connections[call.peer] = @$peer.id

      call.answer(@$localStream)
      call.on 'stream', (stream) =>
        video = @$els.video
        video.src = window.URL.createObjectURL(stream)
        video.onloadedmetadata = (e) -> video.play()
        console.log call, stream

      return if @connections[@$peer.id] == call.peer
      @$peer.call(call.peer, @$localStream)

    mediaGetSucceeded: (stream) ->
      console.log 'mediaGetSucceeded', stream
      @$localStream = stream
      @joinRoom(@meetingId)

    mediaGetFailed: (err) ->
      console.error(err)

    streamReceived: (stream) ->
      console.log 'streamReceived', stream
