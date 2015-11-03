class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meeting

  def show
  end

  def join
    if @meeting.users.find_by(id: current_user.id)
      WebscoketRails["room/#{room.token}"].trigger(
        :member_joined, peer_id: params[:peer_id])
      render :nothing, status: :created
    else
      render :nothing, status: :forbidden
    end
  end

  def leave
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:meeting_id])
  end
end
