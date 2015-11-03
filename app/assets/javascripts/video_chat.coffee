navigator.getUserMedia =
  navigator.getUserMedia ||
  navigator.webkitGetUserMedia ||
  navigator.mozGetUserMedia

Vue.component 'survay-video-chat',
  template: '#survay-video-chat'

  data:
    peerId: null

  events:
    'hook:created': ->
      @$peer = new Peer(key: 'y7i7yij7g2pgb9')
      @$peer.on 'open', @peerOpened
      @$peer.on 'call', @callReceived

      config = { audio: true, video: true }
      navigator.getUserMedia(config, @mediaGetSucceeded, @mediaGetFailed)

  methods:
    peerOpened: (id) ->
      console.log "My peer ID is: #{id}"

    callReceived: (call) ->
      console.log 'callReceived'
      call.answer(@$localStream)
      call.on('stream', @streamReceived)

    streamReceived: (stream) ->
      console.log 'streamReceived'
      video = @$els.remoteVideo
      video.src = window.URL.createObjectURL(stream)
      video.onloadedmetadata = (e) -> video.play()

    mediaGetSucceeded: (stream) ->
      video = @$els.localVideo
      video.src = window.URL.createObjectURL(stream)
      video.onloadedmetadata = (e) -> video.play()
      @$localStream = stream

    mediaGetFailed: (err) ->
      console.error(err)

    connectBtnClicked: (el) ->
      unless navigator.getUserMedia
        console.error 'getUserMedia not supported'
        return
      console.log @peerId, @$localStream
      @$peer.call @peerId, @$localStream
