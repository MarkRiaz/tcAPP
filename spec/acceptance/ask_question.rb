require 'rails_helper'

feature 'user ask question', %q{
  user can ask question
  after user can see index
} do

    let!(:questions) { create_list(:question, 3) }

      scenario 'user try ask question' do
        
        visit new_question_path	
 
        fill_in 'question_title', with: 'MyString'
        fill_in 'question_body', with: 'MyText'
        click_on 'create question'
        
        expect(current_path).to eq questions_path

        #expect(page).to have_content 'Your question successfully created.'

	questions.each do |question|
       	  expect(page).to have_content question.title
        end
         
      end 

    scenario 'user try see all questions' do
      
     visit questions_path
     
     expect(current_path).to eq questions_path
 
     questions.each do |question|
       expect(page).to have_content question.title
       expect(page).to have_content question.body   
     end
     

    end
  end      
