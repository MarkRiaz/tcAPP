require 'rails_helper'

RSpec.describe AttachmentController, type: :controller do
  sign_in_user

  let(:another_user) { create :user }
  let!(:question) { create(:question, user: another_user) }
  let!(:question_file) { create(:attachment, attachable: question) }
  
  describe 'DELETE #destroy' do
    describe 'Questions' do
      context 'not author of file' do
        it 'try to delete file' do
          expect { delete :destroy, id: question_file, format: :js }.not_to change(Attachment, :count)
        end
      end

      context 'author of file' do
        before { question.update_attribute(:user, @user) }

        it 'deletes files' do
          expect { delete :destroy, id: question_file, format: :js }.to change(question.attachments, :count).by(-1)
        end

        it 'render destroy template' do
          delete :destroy, id: question_file, format: :js

          expect(response).to render_template :destroy
        end
      end
    end

    describe 'Answers' do
      let!(:answer) { create(:answer, question: question, user: another_user) }
      let!(:answer_file) { create(:attachment, attachable: answer) }

      context 'not author of file' do
        it 'try to delete answer file' do
          expect { delete :destroy, id: answer_file, format: :js }.not_to change(Attachment, :count)
        end
      end

      context 'author of file' do
        before { answer.update_attribute(:user, @user) }

        it 'deletes files' do
          expect { delete :destroy, id: answer_file, format: :js }.to change(answer.attachments, :count).by(-1)
        end

        it 'render destroy template' do
          delete :destroy, id: answer_file, format: :js

          expect(response).to render_template :destroy
        end
      end
    end
  end
end
