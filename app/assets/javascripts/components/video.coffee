Vue.component 'survay-video',
  template: '#survay-video'
  props: ['src', 'width', 'height', 'caption']

  data: ->
    loaded: false

  ready: ->
    @$els.video.addEventListener 'loadedmetadata', =>
      @loaded = true
