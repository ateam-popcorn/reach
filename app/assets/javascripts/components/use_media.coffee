Vue.component 'survay-use-media',
  template: '<slot></slot>'
  events:
    'hook:created': ->
      config = { audio: true, video: true }
      navigator.getUserMedia(config, @mediaGetSucceeded, @mediaGetFailed)

  methods:
    mediaGetSucceeded: (stream) ->
      @$broadcast('SurvayUseMedia:mediaGetSucceeded', stream)

    mediaGetFailed: (err) ->
      console.error err
