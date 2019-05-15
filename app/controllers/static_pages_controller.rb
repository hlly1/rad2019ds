class StaticPagesController < ApplicationController
  before_action :home_redirect, only: [:home]
  
  def home
  end

  def send_email
    if params[:sendemail]
      UserMailer.welcome_email(params[:name], params[:email], params[:message]).deliver
      flash[:success] = "Email sent successfully!"
      redirect_to root_path
    end
  end
  def contact_us
  end

  private
    
    def home_redirect
      if logged_in?
        redirect_to allcourse_path
      end
    end
  
  
end
