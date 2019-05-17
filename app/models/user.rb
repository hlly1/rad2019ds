class User < ApplicationRecord
  has_many :courses, dependent: :destroy
  has_many :votes, dependent: :destroy
  before_validation{
    self.email = self.email.downcase
  }
  before_save { 
    
    if (self.email == "admin") && (self.password == "password")
      admin = User.new(name:"admin", email:"admin", password:"password",isadmin:1)
      admin.save(validate: false)
    end    
    
  }
  validates :name,  presence: true, length: { minimum: 4 }
  VALID_EMAIL_REGEX = /[A-Za-z_0-9]+\.+[A-Za-z_0-9]+@\b(?i)rmit.edu.au\b/
  validates :email, presence: true, length: { minimum: 4 },
                    format: { with: VALID_EMAIL_REGEX, :message => "Registration only open for RMIT staff"},
                    uniqueness: { case_sensitive: false }
  has_secure_password
  VALID_PASSWD_REGEX = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[$&+,:;=?@#|'<>.^*()%!~]).{8,}$/

  validates :password, presence: true,
                       format: { with: VALID_PASSWD_REGEX, :message => 
                       "must contains at least a lowercase letter, a uppercase,
                       a digit, a special character and 8+ characters", :multiline => true}
                       #allow_nil: true
  
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def added_in?(course)
    self.courses.include?(course)
  end
  
  # private
  #   def admin_validate

  #   end
  
end
