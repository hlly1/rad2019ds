class StaticPagesController < ApplicationController
  before_action :home_redirect, only: [:home]
  
  def home
  end

  private
    
    def home_redirect
      if logged_in?
        redirect_to allcourse_path
      end
    end
  
  
end
