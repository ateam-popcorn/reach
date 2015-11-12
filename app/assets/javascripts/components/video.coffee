Vue.component 'survay-video',
  template: '#survay-video'
  props: ['src', 'width', 'height', 'caption', 'selfy']

  events:
    'SurvayUseMedia:mediaGetSucceeded': (stream) ->
      console.debug 'hoge'
      if @selfy
        @src = window.URL.createObjectURL(stream)

  data: ->
    loaded: false

  ready: ->
    @$els.video.addEventListener 'loadedmetadata', =>
      @loaded = true
