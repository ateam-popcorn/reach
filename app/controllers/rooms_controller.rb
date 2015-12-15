class RoomsController < ApplicationController
  before_action :set_meeting
  before_action :authenticate_user!
  before_action :authenticate_meeting_member!

  def show
  end

  def join
    WebsocketRails[channel].trigger(
      :member_joined,
      peer_id: params[:peer_id], user: current_user, profile: current_user.profile
    )

    head :ok
  end

  def leave
  end

  def welcome
    WebsocketRails[channel].trigger(
      :welcome_received,
      peer_id: params[:peer_id], user: current_user, profile: current_user.profile
    )

    head :ok
  end

  private

  def channel
    "meetings_#{@meeting.id}"
  end

  def set_meeting
    @meeting = Meeting.find(params[:meeting_id])
  end

  def authenticate_meeting_member!
    head :forbidden unless @meeting.users.find_by(id: current_user.id)
  end
end
