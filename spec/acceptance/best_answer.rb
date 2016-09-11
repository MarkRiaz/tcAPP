require_relative 'acceptance_helper'

feature 'best answer', %q{
  user can see answers
  after user try to add best answer
} do

    given!(:question) { create(:question) }
    given(:answer) { create(:answer, question: question, user: user) }
    given(:user) { create(:user) }
    scenario 'unauth user try to edit question' do
      visit question_path(question)

      expect(page).to_not have_link 'best'
    end


    scenario 'auth user', js: true do
        sign_in(answer.user)
        visit question_path(question)


        within '.answers' do
          expect(page).to have_link 'best'
          click_on 'best'
        end
        save_and_open_page
        within '.best' do
          expect(page).to have_content 'Best answer: MyText'
        end
    end
  end
