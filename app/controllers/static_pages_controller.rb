class StaticPagesController < ApplicationController
  def home
    
  end

  def index
    @users = User.all
    @courses = Course.all
  end
  
  
  
  
end
