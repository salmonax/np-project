require 'spec_helper'

describe Profile do
  context 'mass assignment' do
    it {should allow_mass_assignment_of :first_name}
    it {should allow_mass_assignment_of :last_name}
    it {should allow_mass_assignment_of :email}
    it {should allow_mass_assignment_of :bio}
    it {should allow_mass_assignment_of :organization}
    it {should allow_mass_assignment_of :website}

  end

  context 'associations' do
    it {should belong_to :user}
  end
end
