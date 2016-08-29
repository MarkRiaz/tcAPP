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
        
        click_on 'задать вопрос'	
 
        fill_in 'question_title', with: 'MyString'
        fill_in 'question_body', with: 'MyText'
        click_on 'create question'
        
        expect(page).to have_content 'Your question successfully created.'
        expect(page).to have_content 'MyString'
        expect(current_path).to eq questions_path
         
      end

      scenario 'guest can not see link задать вопрос' do
        
        visit questions_path
        expect(page).to_not have_content 'задать вопрос'  

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

