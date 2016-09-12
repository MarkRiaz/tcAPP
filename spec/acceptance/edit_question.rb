require_relative 'acceptance_helper'

feature 'edit question', %q{
  user can see question
  after user try to edit question
} do

    given!(:question) { create(:question) }
    given(:answers) { create_pair(:answer, question: question, user: user) }
    given(:user) { create(:user) }
    scenario 'unauth user try to edit question' do
      visit question_path(question)

      expect(page).to_not have_link 'edit question'
    end


    scenario 'auth user and author try to edit question', js: true do
        sign_in(question.user)
        visit question_path(question)
        expect(page).to have_link 'edit_question'

        click_on 'edit_question'
        fill_in 'question_title', with: 'MyTitle1234'
        fill_in 'question_body', with: 'MyText1234'
        click_on 'edit'
        expect(page).to have_content 'MyTitle1234'
        expect(page).to have_content 'MyText1234'

    end
    scenario 'auth user and not author try to edit question', js: true do
       sign_in(user)
       visit question_path(question)

       expect(page).to_not have_link 'edit question'
    end
  end
