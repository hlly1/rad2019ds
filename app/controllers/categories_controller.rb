class CategoriesController < ApplicationController
  before_action :login_validation, only: [:new, :create]

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
  
  def login_validation
    if !logged_in?
      redirect_to root_path
    end
  end
  
end
