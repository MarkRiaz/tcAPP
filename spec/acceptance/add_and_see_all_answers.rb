require 'rails_helper'

feature 'user add answer', %q{
  user can see question
  after user can add answer
} do

    let!(:question) { create(:question) }
    let!(:answers) { create_pair(:answer, question: question) } 
    given(:user) { create(:user) }

      scenario 'fix bug', js: true do 
        sign_in(user)       
        visit questions_path
        
        click_on 'задать вопрос'	
 
        fill_in 'question_title', with: 'MyString'
        fill_in 'question_body', with: 'MyText'

        click_on 'create question'
        click_on 'MyString'

        fill_in 'answer_body', with: 'Ошибка'
        click_on 'create answer'
        
        save_and_open_page
      end


      #scenario 'user see question and try to add answer', js: true do
        #sign_in(user)       
        
        #visit question_path(question)

	#expect(page).to have_content question.title
        #expect(page).to have_content question.body
 
       # fill_in 'answer_body', with: 'MyText'
       # click_on 'create answer'
        #save_and_open_page
        #expect(page).to have_content 'Your answer successfully created.'
       # expect(page).to have_content 'MyText'
        #save_and_open_page
       # expect(current_path).to eq question_path(question)
         
    #  end

      scenario 'answer не сохраняется' do 
        sign_in(user) 
        visit question_path(question)      

        click_on 'create answer'
  
        expect(page).to have_content 'Your answer could not be created.' 
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
