Vue.component 'survay-use-media',
  template: '<slot></slot>'
  events:
    'hook:created': ->
      config = { audio: true, video: true }
      navigator.getUserMedia(config, @mediaGetSucceeded, @mediaGetFailed)

  methods:
    mediaGetSucceeded: (stream) ->
      @$audioContext = new AudioContext()
      source = @$audioContext.createMediaStreamSource(stream)
      @$analyser = @$audioContext.createAnalyser()

      source.connect(@$analyser)
      @$analyser.connect(@$audioContext.destination)

      @$broadcast('SurvayUseMedia:mediaGetSucceeded', @, stream)

    mediaGetFailed: (err) ->
      console.error err

    getVoiceVolume: ->
      array = new Uint8Array(@$analyser.frequencyBinCount)
      @$analyser.getByteFrequencyData(array)

      sum = 0
      for v in array
        sum += v

      sum / array.length
