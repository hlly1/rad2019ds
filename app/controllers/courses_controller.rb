class CoursesController < ApplicationController
  def new
    @course = Course.new
    @categories = Category.all
    @locations = Location.all
  end

  def update  
    params[:course][:category_ids] ||= []  
    @course = Course.find(params[:id])  
    if @course.update_attributes(params[:course])  
      flash[:notice] = 'Course was successfully updated.'  
      redirect_to :action => 'show', :id => @course  
    else  
      render 'edit'  
    end  
  end 

  def create
    @categories = Category.all
    @locations = Location.all
    @course = Course.new(course_params)
    @course.category_ids = params[:course][:category_ids]
    @course.location_ids = params[:course][:location_ids]
    if @course.save
      # sign up successfully
      flash[:success] = "Course added successfully!"
      redirect_to allcourse_path
    else
      render 'new'
    end
  end
  
  private
    def course_params
      params.require(:course).permit(:name,:prerequisite,:description,:user_id,:category_ids,:location_ids)
    end
  
  
  
  
  
  
end
