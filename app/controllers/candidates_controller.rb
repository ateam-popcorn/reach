class CandidatesController < ApplicationController
  def new
    @question = Question.find_by(research_id: params[:research_id])
    @candidate = Candidate.new
  end

  def create
    
  end

  def check
    redirect_to researches_path
  end

end
