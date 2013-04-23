class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_one :profile

  after_create :make_profile

  def name
    if self.profile.first_name && self.profile.last_name
      self.profile.first_name + ' ' + self.profile.last_name
    else
      self.email
    end
  end

  private

  def make_profile
    self.create_profile
  end
end
