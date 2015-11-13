Vue.component 'survay-chat-container',
  template: '#survay-chat-container'
  props: ['roomToken', 'meetingId']

  data: ->
    connections: {}
    user: null

  events:
    'hook:created': ->
      @$connections = {}

    'SurvayUseMedia:mediaGetSucceeded': (sender, stream) ->
      console.log 'mediaGetSucceeded', stream
      @$localStream = stream
      @$userMediaVm = sender

      @$ws = new WebSocketRails("#{location.host}/websocket")
      memberChannel = @$ws.subscribe "meetings_#{@meetingId}", =>
        memberChannel.bind 'member_joined', @memberJoined
        memberChannel.bind 'volume_received', @volumeReceived

      @$ws.on_open = =>
        @joinRoom @meetingId

  methods:
    joinRoom: (meetingId, cb) ->
      @$peer = new Peer
        host: 'pop-survey-peerjs-server.herokuapp.com'
        port: 443
        secure: true
        path: '/'

      @$peer.on 'open', (id) =>
        console.log "my peer id: #{id}"
        $.post("/meetings/#{meetingId}/room/member", peer_id: id).done =>
          cb() if cb

      @$peer.on 'call', @callReceived
      @$peer.on 'connection', @connectionReceived

    memberJoined: (data) ->
      if @$peer.id == data.peer_id
        @user = data.user

        # send a mic volume
        setInterval =>
          @$ws.trigger 'volume.update',
            email: @user.email
            volume: @$userMediaVm.getVoiceVolume()
            meeting_id: @meetingId
        , 100
      else
        @$peer.call(data.peer_id, @$localStream, metadata: { user: @user })

    callReceived: (call) ->
      console.log 'callReceived', call
      caller = call.metadata.user

      call.answer(@$localStream)
      call.on 'stream', (stream) =>
        console.log 'streamReceived', stream
        console.log call, stream

        Vue.set @connections, caller.email,
          caller: caller
          peer: call.peer
          streamURL: window.URL.createObjectURL(stream)
          volume: 0

      return if @connections[caller.email]
      @$peer.call(call.peer, @$localStream, metadata: { user: @user })

    volumeReceived: (data) ->
      return if !@user || @user.email == data.email
      @connections[data.email]?.volume = data.volume

      sum = 0

      for _, c of @connections
        sum += c.volume

      @averageVolume = sum / Object.keys(@connections).length

    connectionReceived: (conn) ->
      conn.on 'open', =>
        conn.on 'data', (data) =>
          console.debug 'dataReceived', conn.label, data
          @connections[conn.label].volume = data.volume

    addConnection: (caller, peer, streamURL) ->
      connection = @findConnection(caller.email)

      if connection
        connection.caller = caller
        connection.peer = peer
        connection.streamURL = streamURL
      else
        @connections[caller.email] =
          caller: caller, peer: peer, streamURL: streamURL
