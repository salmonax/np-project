require 'spec_helper'

describe User do
  context 'accessibility' do
    it {should allow_mass_assignment_of :email}
    it {should allow_mass_assignment_of :password}
    it {should allow_mass_assignment_of :password_confirmation}
    it {should allow_mass_assignment_of :remember_me}
  end

  context 'callbacks' do
    it "is created with an empty profile" do
      user = FactoryGirl.create(:user)
      user.profile.should_not be_nil
    end
  end

  context 'associations' do 
    it {should have_one :profile}
  end

  context '#name' do
    it 'returns the email if the profile table does not exist' do
      user = FactoryGirl.create(:user)
      user.name.should eq user.email
    end
    it 'returns the first and last name from the profile table if it exists' do
      user = FactoryGirl.create(:user)
      user.profile.update_attributes(first_name: 'Bob', last_name: 'Smith')
      user.name.should eq 'Bob Smith'
    end
  end
end
