class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :load_question, only: [:create]

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
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
    params.require(:answer).permit(:body)
  end
 

end
