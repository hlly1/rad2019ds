class StaticPagesController < ApplicationController
  def home
    
  end

  def web
    @users = User.all
    @categories = Category.all  
  end  
  
  def locat141030
    @users = User.all
    @locations = Location.all  
  end
  
  def locat140826
    @users = User.all
    @locations = Location.all  
  end
  
  def locat141031
    @users = User.all
    @locations = Location.all
  end
  
  def index
    @users = User.all
    @courses = Course.all
  end
  
  
  
  
end
