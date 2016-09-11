require_relative 'acceptance_helper'

feature 'user add answer', %q{
  user can see question
  after user can add answer
} do

    given!(:question) { create(:question) }
    given(:answers) { create_pair(:answer, question: question) }
    given(:user) { create(:user) }

      scenario 'user see question and try to add answer', js: true do
        sign_in(user)

        visit question_path(question)

	      expect(page).to have_content question.title
        expect(page).to have_content question.body

        fill_in 'answer_body', with: 'MyText'
        click_on 'create answer'

        expect(page).to have_content 'MyText'
        expect(current_path).to eq question_path(question)

      end

      scenario 'answer не сохраняется', js: true do
        sign_in(user)
        visit question_path(question)

        #save_and_open_page
        click_on 'create answer'

        expect(page).to have_content "Body is too short (minimum is 1 character)"
      end

      scenario 'guest can not see link create answer' do

        visit question_path(question)
        expect(page).to_not have_content 'create answer'

      end

    scenario 'user try see question and all answers' do

      visit question_path(question)

      question.answers.each do |answer|
        expect(page).to have_content answer.body
      end

    end
  end
