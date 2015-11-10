class ResearchesController < ApplicationController
  def index
    @researches = Research.all

    @meetings = Array[]
    @researches.each do |research|
      research.meetings.each do |meeting|
        participant = meeting.participants.find_by(user: current_user)
        @meetings.push meeting
      end
    end
    @meetings = @meetings.sort_by{|val| val['start_at']}

  end

  def show
    @research = Research.find(params[:id])
  end

  def new
    @research = Research.new
  end

  def create
    @research = Research.new(research_params)
    @research.save
    redirect_to researches_path
  end

  private
  def research_params
    params[:research].permit(:title, :start_at, :end_at, :reward, :max_users, :min_users)
  end


end
