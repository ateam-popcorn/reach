class CandidatesController < ApplicationController
  def new
    @research = Research.find_by(id: params[:research_id])
    @question = Question.find_by(research_id: params[:research_id])
    @candidate = Candidate.new
  end

  def create
    @research = Research.find_by(id: params[:research_id])
    @candidate = @research.candidates.build
    params['research']['questions_attributes'].each do |_,q|
      question = Question.find(q['id'])
      p "hogehoge"
      p question.pass_answer
      p q['answer']
      if question.pass_answer != q['answer'].to_i
        @candidate.user_id = current_user.id
        @candidate.status = 1
        @candidate.save
        redirect_to researches_path
        return
      end
    end

    @candidate.user_id = current_user.id
    @candidate.status = 0
    @candidate.save
    redirect_to researches_path
  end

end
