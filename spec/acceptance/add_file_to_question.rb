require_relative 'acceptance_helper'

feature 'Add files to question', %q{
  In order to illustrate my question
  As an question's author
  I'd like to be able to attach files
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User adds file when asks question' do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'
    attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    click_on 'create question'
    click_on 'Test question'

    expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
  end

  scenario 'User adds files when asks question', js: true do

    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    click_on 'add file'

    within(all(:css, '.fields').first) do
      attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    end

    within(all(:css, '.fields').last) do
      attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    end

    click_on 'create question'
    click_on 'Test question'

    within '.question' do
      expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end

  scenario 'User adds file when edit question', js: true do
    visit question_path(question)


      click_on 'edit_question'

    within '.question' do
      click_on 'add file'
      attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
      click_on 'edit'
    end

    within '.question' do
      expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
    end
  end
  scenario 'User adds file when adds answer, and try to delete it', js: true do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    click_on 'create question'
    click_on 'Test question'
    within '.question' do
      expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
    end

    within '.question' do
      click_on 'delete file'
      expect(page).to_not have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
    end
  end
end
