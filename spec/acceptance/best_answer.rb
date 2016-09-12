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


    scenario 'auth user and author choose best', js: true do
        sign_in(question.user)
        visit question_path(question)

        fill_in 'answer_body', with: 'MyText'
        click_on 'create answer'

        within '.answers' do
          expect(page).to have_link 'best'
          click_on 'best'
        end
        within '.best' do
          expect(page).to have_content 'Best answer: MyText'
        end
    end
    scenario 'auth user and not author try choose best', js: true do
       sign_in(user)
       visit question_path(question)
       fill_in 'answer_body', with: 'MyText'
       click_on 'create answer'

       within '.answers' do
         expect(page).to_not have_link 'best'
       end
    end
  end
