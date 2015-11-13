class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meeting

  def show
  end

  def join
    if @meeting.users.find_by(id: current_user.id)
      p "meetings_#{params[:meeting_id]}"
      WebsocketRails["meetings_#{params[:meeting_id]}"].trigger(
        :member_joined,
        peer_id: params[:peer_id], user: current_user
      )

      head :created
    else
      head :forbidden
    end
  end

  def leave
  end

  def new_message
    logger.debug("Call new_message : #{message}")
    broadcast_message :new_message, message
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:meeting_id])
  end
end
