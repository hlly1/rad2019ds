class LocationsController < ApplicationController
  before_action :login_validation, only: [:new, :create]
  
  def show
    @location = Location.find(params[:id])
    @locations = Location.all
    @users = User.all
  end
  
  def new
     @location = Location.new
  end
  
  def create
    @location = Location.new(location_params)
    if @location.save
      flash[:success] = "Location added successfully!"
      redirect_to addlocation_path
    else
      flash.now[:danger] = 'Invalid name for location'
      render 'new'
    end
  end  
  
  private

  def location_params
    params.require(:location).permit(:name)
  end
  
  def login_validation
    if !logged_in?
      redirect_to root_path
    end
  end
end
