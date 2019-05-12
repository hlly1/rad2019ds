class UserMailer < ApplicationMailer
  default from: 'dataerror0@gmail.com'
 
  def welcome_email(user)
    @user = user
    mail(to: 'dataerror0@gmail.com', subject: 'Welcome to My Awesome Site')
  end
  
end