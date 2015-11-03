class ParticipantsController < ApplicationController
  before_action :set_meeting

  def create
    @participant = Participant.new
    @participant.user = current_user
    @participant.meeting = @meeting

    if @participant.save
      render json: @participant, status: :created
    else
      render json: @participant.errors.full_messages,
             status: :unprocessable_entity
    end
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:meeting_id])
  end
end
