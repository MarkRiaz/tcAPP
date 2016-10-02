require_relative 'acceptance_helper'

feature 'Add files to question', %q{
  In order to illustrate my answer
  As an answer's author
  I'd like to be able to attach files
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  let!(:answer) { create(:answer, question: question, user: user) }
  background do
    sign_in(user)
    visit question_path(question)
  end

    scenario 'User adds file when add answer', js: true do
      fill_in 'Body', with: 'text text text'

      attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
      click_on 'create answer'

      within '.answers' do
        expect(page).to have_link 'rails_helper.rb'
      end
    end

    scenario 'User adds files when add answer', js: true do
      fill_in 'Body', with: 'text text text'
      click_on 'add file'

      within(all(:css, '.fields').first) do
        attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
      end

      within(all(:css, '.fields').last) do
        attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
      end

      click_on 'create answer'

      #save_and_open_page
      within '.answers' do
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end
    end

    scenario 'User adds file when edit answer', js: true do

      within '.answers' do
        click_on 'edit answer'
        fill_in 'Body', with: 'text text text'
        click_on 'add file'
        attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
        click_on 'edit'
      end
      within '.answers' do
        expect(page).to have_link 'rails_helper.rb'
      end
    end

    scenario 'User adds file when adds answer, and try to delete it', js: true do
      fill_in 'Body', with: 'text text text'

      attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
      click_on 'create answer'

      within '.answers' do
        expect(page).to have_link 'rails_helper.rb'
      end

      within '.answers' do
        click_on 'delete file'
        expect(page).to_not have_link 'rails_helper.rb'
      end
    end
 end
