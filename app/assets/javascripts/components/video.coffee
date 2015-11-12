Vue.component 'survay-video',
  template: '#survay-video'
  props: ['src', 'width', 'height', 'caption']

  methods:
    setSelfSize: ->
      # console.debug 'hoge'
      # video = @$els.video
      # video.addEventListener 'loadedmetadata', =>
      #   console.log video.videoWidth, video.videoHeight
      #   @$el.width = video.videoWidth
      #   @$el.height = video.videoHeight

  ready: ->
    @setSelfSize()

    @$watch 'this.src', (val, old) =>
      @setSelfSize()
