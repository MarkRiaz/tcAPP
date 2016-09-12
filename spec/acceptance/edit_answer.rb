require_relative 'acceptance_helper'

feature 'edit answer', %q{
  user can see answer
  after user try to edit answer
} do

    given!(:question) { create(:question) }
    given(:answer) { create(:answer, question: question, user: user) }
    given(:user) { create(:user) }
    scenario 'unauth user try to edit question' do
      visit question_path(question)

      expect(page).to_not have_link 'edit answer'
    end


    scenario 'auth user and author try to edit answer', js: true do
        sign_in(answer.user)
        visit question_path(question)

        fill_in 'answer_body', with: 'MyText'
        click_on 'create answer'

        expect(page).to have_link 'edit answer'

        within '.answers' do
          click_on 'edit answer'
          expect(page).to have_content 'Body'
          fill_in 'answer_body', with: 'MyText1234'
          click_on 'edit'
          expect(page).to have_content 'MyText1234'
        end
    end
    scenario 'auth user and not author try to edit answer', js: true do
       sign_in(user)
       visit question_path(question)
       fill_in 'answer_body', with: 'MyText'
       click_on 'create answer'

       within '.answers' do
         expect(page).to_not have_link 'edit answer'
       end
    end
  end
