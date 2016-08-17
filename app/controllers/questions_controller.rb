class QuestionsController < ApplicationController
   
  def index
   @questions = Question.all
  end
  
  def show
   @question = Question.find(params[:id])
<<<<<<< HEAD
   @answer  = @question.answers
=======
   #@answers  = @question.answers
>>>>>>> d82ba69d48feb322473c20368368a52527f50b32
  end

  def new
   @question = Question.new
  end
  
  def create
   @question = Question.new(question_params)
     if @question.save
       redirect_to @question
     else
       render :new
     end 
  end

  private

  def question_params
    params.require(:question).permit(:body, :title)
  end
end
