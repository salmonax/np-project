def create_user_and_sign_in(user=FactoryGirl.create(:user))
  visit root_path
  click_link 'Sign up'
  fill_in 'Email', :with => 'testuser@email.com'
  fill_in 'Password', :with => 'password'
  fill_in 'Password confirmation', :with => 'password'
  click_button 'Sign up'
end