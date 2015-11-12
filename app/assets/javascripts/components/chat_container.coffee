Vue.component 'survay-chat-container',
  template: '#survay-chat-container'
  props: ['roomToken', 'meetingId']

  data: ->
    connections: []
    user: null

  events:
    'hook:created': ->
      # @connections = {}
      ws = new WebSocketRails("#{location.host}/websocket")
      channel = ws.subscribe "meetings_#{@meetingId}", =>
        channel.bind 'member_joined', @memberJoined

    'SurvayUseMedia:mediaGetSucceeded': (stream) ->
      console.log 'mediaGetSucceeded', stream
      @$localStream = stream
      @joinRoom(@meetingId)

  methods:
    joinRoom: (meetingId) ->
      @$peer = new Peer(key: 'y7i7yij7g2pgb9')
      @$peer.on 'open', (id) =>
        console.log "my peer id: #{id}"
        $.post("/meetings/#{meetingId}/room/member", peer_id: id)

      @$peer.on 'call', @callReceived

    memberJoined: (data) ->
      if @$peer.id == data.peer_id
        @user = data.user
      else
        console.log "memberJoined: ", data
        console.log "#{data.user.email}'s peer id: #{data.peer_id}"

        @$peer.call(data.peer_id, @$localStream, metadata: { user: @user })

    callReceived: (call) ->
      console.log 'callReceived', call
      @connections[call.peer] = @$peer.id
      caller = call.metadata.user

      call.answer(@$localStream)
      call.on 'stream', (stream) =>
        console.log 'streamReceived', stream
        console.log call, stream
        @addConnection caller, call.peer, window.URL.createObjectURL(stream)

      return if @findConnection(caller.email)
      @$peer.call(call.peer, @$localStream, metadata: { user: @user })

    addConnection: (caller, peer, streamURL) ->
      connection = @findConnection(caller.email)

      if connection
        connection.caller = caller
        connection.peer = peer
        connection.streamURL = streamURL
      else
        @connections.push(caller: caller, peer: peer, streamURL: streamURL)

    findConnection: (email) ->
      for c in @connections
        return c if c.caller.email == email

      null
