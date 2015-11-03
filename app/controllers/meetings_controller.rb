class MeetingsController < ApplicationController
  def index
    meetings = Meeting.all
    researches = Research.all
    @m_titles = []


    meetings.each{ |m|
      researches.each { |r|
        if r.id == m.research.id then
          @m_titles.push(id: m.id, title: r.title, start_at: m.start_at, end_at: m.end_at)
        end
      }
    }
  end

  def show
    @meeting = Meeting.find(params[:id])
    @research = Research.find(@meeting.research_id)
  end

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
