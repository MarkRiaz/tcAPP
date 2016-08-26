class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  
  def index
   @questions = Question.all
  end
  
  def show
   @question = Question.find(params[:id])
   @answer  = @question.answers.build
  end

  def new
   @question = Question.new
  end
  
  def create
   @question = Question.new(question_params)
     if @question.save
       redirect_to questions_path
     else
       render :new
     end 
  end

  private

  def question_params
    params.require(:question).permit(:body, :title)
  end
end
