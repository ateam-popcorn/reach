class MeetingsController < ApplicationController
  def new
    @meeting = Meeting.new
  end

  def create
    @meeting = Meeting.new(meeting_params)

    if @meeting.save
      flash[:notice] = 'hogehoge'
    else
      flash[:error] = 'error'
      redirect_to :back
    end

    redirect_to action: :index
  end

  private

  def meeting_params
    params.require(:meeting).permit(:start_at, :end_at)
  end
end
