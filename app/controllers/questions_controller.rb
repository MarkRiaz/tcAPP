class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]

  def index
   @questions = Question.all
  end

  def show
   @answer  = @question.answers.build
   #@answers  = @question.answers
  end

  def new
   @question = Question.new
  end

  def create
   @question = Question.new(question_params.merge(user: current_user))
     if @question.save
       flash[:notice] = 'Your question successfully created.'
       redirect_to questions_path
     else
       flash[:notice] = 'Your question could not be created'
       render :new
     end
  end

  def edit
  end

  def update
    @question = Question.find(params[:id])
    if current_user.author_of?(@question)
      @question.update(question_params)
    end
  end

  def destroy
    if current_user.author_of?(@question)
      @question.destroy
      flash[:notice] = 'Your question successfully deleted.'
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
    params.require(:question).permit(:body, :title, :best_answer_id)
  end
end
