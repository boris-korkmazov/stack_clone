require 'rails_helper'

feature 'Add files to answer', %q{
  In order to add a file to an answer
  As answer's creator
  I want to be able to add a file to an answer
} do
  given(:user){create :user}

  given!(:question){create :question}

  background do
    sign_in user
    visit question_path(question)
  end

  scenario 'User add file when create question', js: true do

    fill_in 'answer_body_create', with: 'Test answer'

    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'
    within '.answers' do
      expect(page).to have_link('spec_helper.rb', href: "/uploads/attachment/file/1/spec_helper.rb")
    end
  end
end