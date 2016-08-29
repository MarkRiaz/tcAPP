require 'rails_helper'

feature 'user ask question', %q{
  to get answer
  as auth user
  I want to ask question
} do

    let!(:questions) { create_pair(:question) }
    given(:user) { create(:user) }

      scenario 'user try ask question' do
        sign_in(user) 
       
        visit new_question_path	
 
        fill_in 'question_title', with: 'MyString'
        fill_in 'question_body', with: 'MyText'
        click_on 'create question'
        
        expect(page).to have_content 'Your question successfully created.'
        expect(current_path).to eq questions_path
         
      end
     
      scenario 'question не сохраняется' do 
        sign_in(user) 
        visit new_question_path       

        fill_in 'question_title', with: 'MyString'
        click_on 'create question'
  
        expect(page).to have_content 'Your question could not be created'
      end
 
      scenario 'user try see all questions' do
        sign_in(user)
 
        visit questions_path    
     
       questions.each do |que|
         expect(page).to have_content que.title 
       end
    
       expect(current_path).to eq questions_path

      end
  end      

