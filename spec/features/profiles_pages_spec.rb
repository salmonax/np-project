require 'spec_helper'

feature 'Edit Profile' do

  scenario 'a new user is sent to the edit profile page after signing up' do
    create_user_and_sign_in
    page.should have_content 'Edit Profile'
  end

  scenario 'a logged in user edits a profile through navbar link' do
    create_user_and_sign_in
    click_on "My Account"
    click_on "Edit profile"
    fill_in "profile_first_name", :with => 'Editor'
    fill_in "profile_last_name", :with => 'McEditorson'
    fill_in "profile_email", :with => 'lotsof@editing.com'
    fill_in "profile_bio", :with => 'I edit things.'
    click_button 'Update Profile'
    page.should have_content 'McEditorson'
  end
end