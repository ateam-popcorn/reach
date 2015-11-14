Vue.component 'survay-chat-tl-container',
  template: '#survay-chat-tl-container'
  props: ['roomToken', 'meetingId']

  data: ->
    connections: {}
    user: null
    comments: []

  events:
    'hook:created': ->
      @$ws = new WebSocketRails("#{location.host}/websocket")
      memberChannel = @$ws.subscribe "meetings_#{@meetingId}", =>
        memberChannel.bind 'comment_received', @commentReceived

  methods:
    bindEvents: () ->
      $('#send').on 'click', @sendMessage
      @$ws.bind 'new_message', @receiveMessage

    sendMessage: (event) ->
      $.post "/meetings/#{@meetingId}/room/comments",
        comment: @newComment
      .done =>
        @newComment = null
      #
      # user_name = $('#username').text()
      # msg_body = $('#msgbody').val()
      # @$ws.trigger 'new_message', { name: user_name , body: msg_body }
    #
    # receiveMessage: (message) ->
    #   console.log message
    #   $('#chat').append "#{message.name}「#{message.body}」<br/>"

    commentReceived: (data) ->
      console.debug 'commentReceived', data
      @comments.push data
