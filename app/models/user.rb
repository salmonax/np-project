class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :name, :username
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

  # def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  #   user = User.where(:provider => auth.provider, :uid => auth.uid).first
  #   unless user
  #     user = User.create(name:auth.extra.raw_info.name,
  #                          provider:auth.provider,
  #                          uid:auth.uid,
  #                          email:auth.info.email,
  #                          password:Devise.friendly_token[0,20]
  #                          )
  #   end
  #   user
  # end

  # def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
  #   user = User.where(:provider => auth.provider, :uid => auth.uid).first
  #   unless user
  #     user = User.create(name:auth.extra.raw_info.name,
  #                          provider:auth.provider,
  #                          uid:auth.uid,
  #                          email:auth.info.email,
  #                          password:Devise.friendly_token[0,20]
  #                          )
  #   end
  #   user
  # end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.email
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end    
  end

  def password_required? 
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  private

  def make_profile
    self.create_profile
  end
end
