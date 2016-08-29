require 'rails_helper'

feature 'user add answer', %q{
  user can see question
  after user can add answer
} do

    let!(:question) { create(:question) }
    let!(:answers) { create_pair(:answer, question: question) } 
    given(:user) { create(:user) }

      scenario 'user see question and try to add answer' do
        sign_in(user)       
        
        visit question_path(question)

	expect(page).to have_content question.title
        expect(page).to have_content question.body
 
        fill_in 'answer_body', with: 'MyText'
        click_on 'create answer'
        
        expect(page).to have_content 'Your answer successfully created.'
        expect(current_path).to eq question_path(question)
         
      end 

    scenario 'user try see question and all answers' do
      
     visit question_path(question)  
     
     question.answers.each do |answer|
       expect(page).to have_content answer.body
     end
     
     expect(current_path).to eq question_path(question)

    end
  end      
