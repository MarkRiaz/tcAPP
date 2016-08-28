require 'rails_helper'

feature 'user ask question', %q{
  to get answer
  as auth user
  I want to ask question
} do

    let!(:questions) { create_list(:question, 3) }
    given(:user) { create(:user) }

      scenario 'user try ask question' do
        sign_in(user) 
       
        visit new_question_path	
 
        fill_in 'question_title', with: 'MyString'
        fill_in 'question_body', with: 'MyText'
        click_on 'create question'
        
        expect(current_path).to eq questions_path

      	questions.each do |question|
       	  expect(page).to have_content question.title
        end
         
      end 

    scenario 'user try see all questions' do
     sign_in(user)
 
     visit questions_path
     
     expect(current_path).to eq questions_path
 
     questions.each do |question|
       expect(page).to have_content question.title 
     end
     

    end
  end      
