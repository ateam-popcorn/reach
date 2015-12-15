class CandidatesController < ApplicationController
  def new
    @research = Research.find_by(id: params[:research_id])
    @question = Question.find_by(research_id: params[:research_id])
    @candidate = Candidate.new
  end

  def create
    @question = Question.find_by(research_id: params[:research_id])

    redirect_to researches_path
  end

end
