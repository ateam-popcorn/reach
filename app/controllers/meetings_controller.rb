class MeetingsController < ApplicationController
  def new
    @meeting = Meeting.new
  end

  def create
    @research = Research.find(params[:research_id])
    @meeting = @research.meetings.create(meeting_params)

    if @meeting.save
      flash[:notice] = 'hogehoge'
    else
      flash[:error] = 'error'
      redirect_to :back
    end

    redirect_to research_path(@research.id)
  end

  private

  def meeting_params
    params.require(:meeting).permit(:start_at, :end_at)
  end
end
