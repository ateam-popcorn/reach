class ChatsController < WebsocketRails::BaseController
  def new_message
    logger.debug("Call new_message : #{message}")
    broadcast_message :new_message, message
  end
end
