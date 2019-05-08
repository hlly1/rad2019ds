class LocationsController < ApplicationController
  
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
end
