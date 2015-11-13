Vue.component 'survay-video',
  template: '#survay-video'
  props: ['src', 'width', 'height', 'caption', 'selfy']

  events:
    'SurvayUseMedia:mediaGetSucceeded': (sender, stream) ->
      return unless @selfy
      @src = window.URL.createObjectURL(stream)
      # stream.getAudioTracks()[0].enabled = false
      # stream.getAudioTracks()[0].muted = true
      # console.log stream.getAudioTracks()[0]

  data: ->
    loaded: false

  ready: ->
    @$els.video.addEventListener 'loadedmetadata', =>
      @loaded = true
