require 'spec_helper'

feature 'registration' do
  scenario 'sign up' do
    create_user_and_sign_in
    page.should have_content "You have signed up successfully"
  end
end