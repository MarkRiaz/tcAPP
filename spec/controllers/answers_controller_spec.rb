require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }

   describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do

      it 'saves the new answer in the database'do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer), format: :js } }.to change(question.answers, :count).by(1)
      end


      it 'saves the new user answer in the database'do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer), format: :js } }.to change(@user.answers, :count).by(1)
      end
    end

    context 'with invalid attributes' do

      it 'does not save the answer' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:invalid_answer), format: :js } }.to_not change(Answer, :count)
      end

    end
  end

  describe 'PATCH #update' do
    sign_in_user

    it 'assings the requested answer to @answer' do
      patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
      expect(assigns(:answer)).to eq answer
    end

    it 'assigns to question' do
      patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
      expect(assigns(:question)).to eq question
    end

    it 'changes answer attributes' do
      answer.update(user_id: @user.id)
      patch :update, id: answer, question_id: question, answer: {body: 'new body'}, format: :js
      answer.reload
      expect(answer.body).to eq 'new body'
    end

    it 'render update template' do
      patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
      expect(response).to render_template :update
    end

    it 'not changes answer attributes to rong user' do
      patch :update, id: answer, question_id: question, answer: {body: 'new body'}, format: :js
      answer.reload
      expect(answer.body).to_not eq 'new body'
    end


  end
  describe 'PATCH #best' do
    sign_in_user
    let(:author_of_answer) { create(:user) }
    let!(:answer_2) { create(:answer, question: question, user: author_of_answer, best: false) }
    context 'Question author choose best answer' do

      it 'assigns the requested answer to @answer' do
        patch :best, id: answer, format: :js
        expect(assigns(:answer)).to eq answer
      end

      it 'set the best answer' do
        answer.update(best: true)
        patch :best, id: answer, format: :js
        answer.reload
        expect(answer.best).to eq true
      end

      it 'choose another best answer' do
        answer_2.update(best: true)
        patch :best, id: answer_2, format: :js
        answer.reload
        answer_2.reload

        expect(answer.best).to eq false
        expect(answer_2.best).to eq true
      end
    end

    context 'Not question author choose best answer' do
      before do
        question.update_attribute(:user, author_of_answer)
      end
      it 'another user tries to choose best answer' do
        patch :best, id: answer, format: :js
        answer.reload

        expect(answer.best).to eq false
      end
    end
  end

  describe 'DELETE #destroy' do
  sign_in_user
  before { answer }

    it 'deletes answer' do
      answer.update(user_id: @user.id)
      expect { delete :destroy, params: { id: answer, format: :js } }.to change(question.answers, :count).by(-1)
    end

    it 'user try destroy not his answer' do
      expect { delete :destroy, params: { id: answer, format: :js } }.to_not change(question.answers, :count)
    end
  end

end
