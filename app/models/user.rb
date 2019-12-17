class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates_length_of :password, :minimum => 6
  validates :password_confirmation, presence: true
  validates_confirmation_of :password, :message => "Password and confirmation should match"

  validates_uniqueness_of :email, :case_sensitive => false

  def self.authenticate_with_credentials(email, password)
    User.find_by(email: email.strip.downcase).authenticate(password)
  end
end
