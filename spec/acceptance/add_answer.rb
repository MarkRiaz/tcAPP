require 'rails_helper'

feature 'user add answer', %q{
  user can see question
  after user can add answer
} do

    let!(:question) { create(:question) }
    let!(:answers) { create_list(:answer, 3) } 

      scenario 'user try ask question' do
        
        visit question_path(question)

	expect(page).to have_content question.title
        expect(page).to have_content question.body
 
        fill_in 'answer_body', with: 'MyText'
        click_on 'create answer'
        
        expect(current_path).to eq question_path(question)

        #expect(page).to have_content 'Your answer successfully created.'
         
      end 

    scenario 'user try see all questions' do
      
     visit question_path(question)
     
     expect(current_path).to eq question_path(question)
 
     answers.each do |answer|     
       expect(page).to have_content answer.body   
     end
     

    end
  end      
