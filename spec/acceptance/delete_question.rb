require 'rails_helper'

feature 'user delete question', %q{
  user see question 
  after user can question answer
} do

    let!(:question) { create(:question) } 
    given(:user) { create(:user)}

      scenario 'user see question and try to delete answer' do
        sign_in(question.user)       
        
        visit question_path(question)

	expect(page).to have_content question.title
        expect(page).to have_content question.body
        
        expect(page).to have_content 'delete_question'             
        
        click_on 'delete_question'
      
        expect(page).to have_content 'Your question successfully deleted.'  
      end 

     scenario 'guest can not see link delete' do     
        
        visit question_path(question)

	expect(page).to have_content question.title
        expect(page).to have_content question.body             
            
        expect(page).to_not have_content 'delete_question'  
      end
   end
