class ResearchesController < ApplicationController
  def index
    @participants = Participant.where(user_id: current_user.id)
    
    @reserved_meetings = Array.new
    @participants.each do |p|
      @reserved_meetings.push(Meeting.find(p.meeting_id))
    end

    @reserved_research = Array.new
    @reserved_meetings.each do |r|
      research = Research.find(r.research_id)
      @reserved_research.push([title: research.title, meeting_it: r.id, start_at: r.start_at])
    end

    @researches = Research.all
    @meetings = Meeting.all
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
