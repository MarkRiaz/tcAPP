class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :best]
  before_action :load_question, only: [:create]
  before_action :load_answer, only: [:destroy, :update, :best]

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def destroy
    @question = @answer.question
    if current_user.author_of?(@answer)
      @answer.destroy
    end
  end

  def update
    if current_user.author_of?(@answer)
      @answer.update(answer_params)
    end
    @question = @answer.question
  end

  def best
    @question = @answer.question
    if current_user.author_of?(@question)
      @answer.best!
    end
 end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer=Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file, :id, :_destroy])
  end


end
