require 'rails_helper'

feature 'Add files to question', %q{
  In order to add file to question
  As an question's author
  I want to be able to attach
} do

  given(:user){create :user}

  background do
    sign_in user
    visit new_question_path
  end

  scenario 'User add file when create question' do

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'test test'

    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'

    expect(page).to have_link('spec_helper.rb', href: "/uploads/attachment/file/1/spec_helper.rb")

  end

end