class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :load_question, only: [:new, :create]

  def create
    @answer = @question.answers.new(answer_params.merge(user: current_user))
    if @answer.save
      flash[:notice] = 'Your answer successfully created.'
      redirect_to @question
    else
      redirect_to question_path(@question)
      flash[:notice] = 'Your answer could not be created.'
    end
  end

  def destroy 
    @answer=Answer.find(params[:id])
    @question = @answer.question
    if current_user.author_of?(@answer) 
      @answer.destroy
      flash[:notice] = 'Your answer successfully deleted.'
    end
    redirect_to @question
  end


  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, :created_at)
  end
 

end
