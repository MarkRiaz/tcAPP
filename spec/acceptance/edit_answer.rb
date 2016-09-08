require_relative 'acceptance_helper'

feature 'edit answer', %q{
  user can see answer
  after user try to edit answer
} do

    given!(:question) { create(:question) }
    given(:answers) { create_pair(:answer, question: question) } 
    given(:user) { create(:user) }
    
    scenario 'unauth user try to edit question' do
      visit question_path(question)

      expect(page).to_not have_link 'Edit'
    end
    

    describe 'auth user' do
      before do
        sign_in(user)
        visit question_path(question)
      end   
    scenario 'user sees link to edit' do
      
      
