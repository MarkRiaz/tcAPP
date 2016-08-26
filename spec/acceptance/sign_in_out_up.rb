require 'rails_helper'

feature 'user sign in', %q{
  in order to be able to ask question
  As an user
  I want to be able to sign in
		       sign out
                       sign up  	
} do

    given(:user) { create(:user) }

    scenario 'Registred user try sign in' do
      #User.create!(email: 'user@mail.com', password: '12345678')        
      sign_in(user)
      #visit new_user_session_path	
 
      #fill_in 'Email', with: 'user@mail.com'
      #fill_in 'Password', with: '12345678'
      #click_on 'Log in'
      
      expect(page).to have_content 'Signed in successfully.'
      expect(current_path).to eq root_path
    end 
   
    scenario 'Registred user try sign out' do
      #User.create!(email: 'user@mail.com', password: '12345678')        
      sign_in(user)

      visit root_path	
 
      #fill_in 'Email', with: 'user@mail.com'
      #fill_in 'Password', with: '12345678'
      #click_on 'Log in'
      
      #expect(page).to have_content 'Signed in successfully.'
      #expect(current_path).to eq root_path

      click_on 'Logout'

      expect(page).to have_content 'Signed out successfully.'
    end 
    
    scenario 'Non-registered user try to sign in' do
      visit new_user_session_path	
 
      fill_in 'Email', with: 'user2@mail.com'
      fill_in 'Password', with: '12345678'
      click_on 'Log in'
      
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content 'Invalid Email or password. Log in Email Password Remember me Sign up Forgot your password?'
    end
    
    scenario 'Non-registered user try to sign up' do
      visit new_user_session_path
      
      click_on 'Sign up'
      #save_and_open_page
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: user.password_confirmation 

      click_on 'Sign up'
 
      expect(page).to have_content 'Welcome! You have signed up successfully.'
      expect(current_path).to eq root_path

    end
  end 
