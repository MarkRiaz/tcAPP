require_relative 'acceptance_helper'

feature 'best answer', %q{
  user can see answers
  after user try to add best answer
} do

    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    given!(:question) { create(:question, user: user) }
    let!(:answer) { create(:answer, question: question, user: user, best: false) }
    let!(:other_answer) { create(:answer, question: question, user: user, best: false) }


    scenario 'unauth user try to edit question' do
      visit question_path(question)

      expect(page).to_not have_link 'best'
    end


    scenario 'auth user and author choose best', js: true do
        sign_in(question.user)
        visit question_path(question)

        within '.answers' do
          expect(page).to have_content answer.body
          expect(page).to have_content other_answer.body
          expect(page).to have_link 'best'
          first(:link, "best").click
        end
        within '.answers' do
          expect(page).to have_content 'BEST ANSWER:'
          expect(page).to have_content answer.body
          expect(page).to have_content(answer.body, :count => 1)
        end
    end
    scenario 'auth user and not author try choose best', js: true do
       sign_in(other_user)
       visit question_path(question)
       fill_in 'answer_body', with: 'MyText'
       click_on 'create answer'

       within '.answers' do
         expect(page).to_not have_link 'best'
       end
    end
  end
