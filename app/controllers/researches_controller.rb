class ResearchesController < ApplicationController
  def index
    @researches = Research.all
  end

  def show
    @research = Research.find(params[:id])
  end
end
