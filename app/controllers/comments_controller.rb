class CommentsController < ApplicationController
  before_action :set_meeting
  before_action :authenticate_user!
  before_action :authenticate_meeting_member!

  def create
    WebsocketRails[channel].trigger(
      :comment_received,
      comment: params[:comment], user: current_user
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
