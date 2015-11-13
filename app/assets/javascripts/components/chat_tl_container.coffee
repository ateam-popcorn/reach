Vue.component 'survay-chat-tl-container',
  template: '#survay-chat-tl-container'
  props: ['roomToken', 'meetingId']

  data: ->
    connections: {}
    user: null
  
  events:
    'hook:created': ->
      @dispatcher = new WebSocketRails("#{location.host}/websocket")

  methods:
    bindEvents: () ->
      $('#send').on 'click', @sendMessage
      @dispatcher.bind 'new_message', @receiveMessage

    sendMessage: (event) ->
      user_name = $('#username').text()
      msg_body = $('#msgbody').val()
      @dispatcher.trigger 'new_message', { name: user_name , body: msg_body }

    receiveMessage: (message) ->
      console.log message
      $('#chat').append "#{message.name}「#{message.body}」<br/>"

