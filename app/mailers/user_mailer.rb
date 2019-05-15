class UserMailer < ApplicationMailer
  default from: '707155591@qq.com'

  def welcome_email(name, email, message)
    @name= name
    @email = email
    @message = message
    mail(to: '707155591@qq.com', subject: 'RAD send email TEST')
  end
  
end