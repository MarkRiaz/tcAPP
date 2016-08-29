require 'rails_helper'

feature 'user delete answer', %q{
  user see question and all answers
  after user can delete answer
} do

    let!(:question) { create(:question) }
    let!(:answer) { create(:answer, question: question) } 
    given(:user) { create(:user)}

      scenario 'user see question and try to delete answer' do
        sign_in(answer.user)       
        
        visit question_path(question)

	expect(page).to have_content question.title
        expect(page).to have_content question.body
        
        expect(page).to have_content answer.body             
        
        click_on 'delete answer'
      
        expect(page).to have_content 'Your answer successfully deleted.'  
      end 
   end
