class User < ApplicationRecord
  has_many :courses
  has_many :votes
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { minimum: 4 }
  VALID_EMAIL_REGEX = /[A-Za-z_0-9]+\.[A-Za-z_0-9]+@\b(?i)rmit.edu.au\b/
  validates :email, presence: true, length: { minimum: 4 },
                    format: { with: VALID_EMAIL_REGEX, :message => "Registration only open for RMIT staff"},
                    uniqueness: { case_sensitive: false }
  has_secure_password
  VALID_PASSWD_REGEX = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,50}$/

  validates :password, presence: true, length: { minimum: 8 },
                       format: { with: VALID_PASSWD_REGEX, :message => "is not correct", :multiline => true}
  
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def added_in?(course)
    self.courses.include?(course)
  end
  
end
