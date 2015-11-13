Vue.component 'survay-video',
  template: '#survay-video'
  props: ['src', 'width', 'height', 'caption', 'selfy']

  events:
    'SurvayUseMedia:mediaGetSucceeded': (sender, stream) ->
      @src = window.URL.createObjectURL(stream) if @selfy

  data: ->
    loaded: false

  ready: ->
    @$els.video.addEventListener 'loadedmetadata', =>
      @loaded = true
