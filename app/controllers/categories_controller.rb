class CategoriesController < ApplicationController
  def show
    @category = Category.find_by(name: params[:name])
    @categories = Category.all
    @users = User.all
  end
  
  
  def new
     @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category added successfully!"
      redirect_to addcategory_path
    else
      flash.now[:danger] = 'Invalid name for location'
      render 'new'
    end
  end  
  
  private

  def category_params
    params.require(:category).permit(:name)
  end
end