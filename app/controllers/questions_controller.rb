class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :destroy]
  
  def index
   @questions = Question.all
  end
  
  def show
   @answer  = @question.answers.build
  end

  def new
   @question = Question.new
  end
  
  def create
   @question = Question.new(question_params.merge(user: current_user))
     if @question.save
       redirect_to questions_path
     else
       render :new
     end 
  end

  def destroy
    if current_user.id == @question.user_id 
      @question.destroy
      redirect_to questions_path
    else
      redirect_to question_path(@question)
    end
  end

  private
  
  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body, :title)
  end
end
