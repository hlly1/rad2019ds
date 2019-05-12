class UsersController < ApplicationController
  before_action :set_user, only: [:destroy]
  def index
    @users = User.all
  end
  
  def edit
    @user = User.find(params[:id])
  end  
  
  def show
    @users = User.all
    @user = User.find(params[:id])
    @courses = @user.courses
  end
  
  def new
     @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      # sign up successfully
      UserMailer.welcome_email(@user).deliver_now
      log_in @user
      flash[:success] = "Welcome to Your Course App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def destroy
    if @user.isadmin == 0
      @user.destroy
      flash[:success] = 'Coordinator deleted successfully!'
      redirect_back(fallback_location: root_path)
    elsif @user.isadmin == 1
      flash[:danger] = "Admin cannot be deleted!"
      redirect_back(fallback_location: root_path)
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
    
    def set_user
      @user = User.find(params[:id])
    end
    
end
