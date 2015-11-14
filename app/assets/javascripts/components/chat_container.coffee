Vue.component 'survay-chat-container',
  template: '#survay-chat-container'
  props: ['roomToken', 'meetingId']

  data: ->
    userConnections: {} # email => {user, peer, streamURL}
    peerConnections: {} # peer  => {user, peer, streamURL}
    user: null

  events:
    'hook:created': ->
      @$connections = {} # peer => MediaConnection

    'SurvayUseMedia:mediaGetSucceeded': (sender, stream) ->
      console.log 'mediaGetSucceeded', stream
      @$localStream = stream
      @$userMediaVm = sender

      @$ws = new WebSocketRails("#{location.host}/websocket")
      memberChannel = @$ws.subscribe "meetings_#{@meetingId}", =>
        memberChannel.bind 'member_joined', @memberJoined
        memberChannel.bind 'volume_received', @volumeReceived
        memberChannel.bind 'welcome_received', @welcomeReceived

      @$ws.on_open = =>
        @joinRoom @meetingId

  methods:
    joinRoom: (meetingId, cb) ->
      @$peer = new Peer null,
        host: 'pop-survey-peerjs-server.herokuapp.com'
        port: 443
        secure: true
        path: '/'

      @$peer.on 'open', (id) =>
        console.log "my peer id: #{id}"
        $.post("/meetings/#{meetingId}/room/join", peer_id: id).done =>
          cb() if cb

      @$peer.on 'call', @callReceived
      @$peer.on 'connection', @connectionReceived
      @$peer.on 'error', (err) =>
        console.error err

        if err.type == 'disconnected'
          @$peer.reconnect()

    memberJoined: (data) ->
      if @$peer.id == data.peer_id
        console.debug 'joinSuccess', data

        @user = data.user

        # send a mic volume
        # setInterval =>
        #   @$ws.trigger 'volume.update',
        #     email: @user.email
        #     volume: @$userMediaVm.getVoiceVolume()
        #     meeting_id: @meetingId
        # , 500
      else
        console.debug 'memberJoined', data
        $.post "/meetings/#{@meetingId}/room/welcome",
          peer_id: @$peer.id
          user: @user

        @addConnection(data.user, data.peer_id, null)

    welcomeReceived: (data) ->
      return if @$peer.id == data.peer_id
      console.debug 'welcomeReceived', data

      @addConnection(data.user, data.peer_id, null)
      call = @$peer.call(data.peer_id, @$localStream)
      @waitStream(call)

    callReceived: (call) ->
      console.debug 'callReceived', call
      call.answer(@$localStream)
      @waitStream(call)

      # return if @userConnections[caller.email]
      # @$peer.call(call.peer, @$localStream, metadata: { user: @user })

    waitStream: (call) ->
      @$connections[call.peer] = call

      call.on 'stream', (stream) =>
        console.debug 'streamReceived', stream
        @setStream(call.peer, window.URL.createObjectURL(stream))

    connectionReceived: (conn) ->
      conn.on 'open', =>
        conn.on 'data', (data) =>
          console.debug 'dataReceived', conn.label, data
          @userConnections[conn.label].volume = data.volume

    addConnection: (user, peer, streamUrl) ->
      newConn =
        user: user
        peer: peer
        streamUrl: streamUrl
        volume: 0

      oldConn = @userConnections[user.email]
      if oldConn
        console.debug 'Close old connection'
        @$connections[oldConn.peer].close()
        @peerConnections[oldConn.peer] = null

      Vue.set @userConnections, user.email, newConn
      Vue.set @peerConnections, peer, newConn

    setStream: (peer, streamUrl) ->
      c = @peerConnections[peer]
      c.streamUrl = streamUrl

      #Vue.set @userConnections, c.user.email, c

    # volumeReceived: (data) ->
    #   return if !@user || @user.email == data.email
    #   @userConnections[data.email]?.volume = data.volume
    #
    #   sum = 0
    #
    #   for _, c of @userConnections
    #     sum += c.volume
    #
    #   @averageVolume = sum / Object.keys(@userConnections).length
