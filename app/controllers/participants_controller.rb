class ParticipantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meeting, only: [:create]

  def create
    @participant = Participant.new
    @participant.user = current_user
    @participant.meeting = @meeting

    if @participant.save
      redirect_to :back
    else
      flash['alart'] = @participant.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    @participant = Participant.find(params[:id])
    if @participant.destroy
      redirect_to :back
    else
      flash['alart'] = @participant.errors.full_messages
      redirect_to :back
    end
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:meeting_id])
  end
end
