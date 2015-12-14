class QuestionsController < ApplicationController
  def new
    @question = Question.new 
  end

  def create
    @research = Research.find(params[:research_id])
    @question = @research.questions.create(question_params)

    if @question.save
      flash[:notice] = 'question saved'
    else
      flash[:error] = 'question error'
      redirect_to :back
    end

    redirect_to research_path(@research.id)
  end

  private
  def question_params
    params.require(:question).permit(:text, :pass_answer)
  end

end
