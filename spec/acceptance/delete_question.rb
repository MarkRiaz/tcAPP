require_relative 'acceptance_helper'

feature 'user delete question', %q{
  user see question
  after user can delete question
} do

    let!(:question) { create(:question) }
    given(:user) { create(:user)}

      scenario 'user see question and try to delete question' do
        sign_in(question.user)

        visit question_path(question)

	      expect(page).to have_content question.title
        expect(page).to have_content question.body

        expect(page).to have_content 'delete_question'

        click_on 'delete_question'

        expect(current_path).to eq questions_path
        expect(page).to have_content 'Your question successfully deleted.'
        expect(page).to_not have_content question.title
      end

     scenario 'guest can not see link delete' do

        visit question_path(question)

	      expect(page).to have_content question.title
        expect(page).to have_content question.body

        expect(page).to_not have_content 'delete_question'
      end
   end
