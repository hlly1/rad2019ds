class CoursesController < ApplicationController
  before_action :set_course_info, only: [:show, :create,:new]
  before_action :set_course, only: [:votelike, :votedislike]
  
  def show
    @course = Course.find_by(name: params[:name])
  end
  
  def votelike
    if logged_in?
      course = Vote.where(course_id: @course_id.id,
      user_id: current_user.id).exists?
      if course
        flash[:danger] = 'You can only vote a course once!'
        redirect_back(fallback_location: root_path)
      else
        Vote.create(dislike: 0, like: 1, course_id: @course_id.id, user_id: current_user.id)
        flash[:success] = 'Course voted successfully!'
        redirect_back(fallback_location: root_path)
      end
      
    else
      flash[:danger] = 'You need to login to vote!'
      redirect_back(fallback_location: root_path)
    end
  end
  
  def votedislike
    if logged_in?
      course = Vote.where(course_id: @course_id.id,
      user_id: current_user.id).exists?
      if course
        flash[:danger] = 'You can only vote a course once!'
        redirect_back(fallback_location: root_path)
      else
        Vote.create(dislike: 1, like: 0, course_id: @course_id.id, user_id: current_user.id)
        flash[:success] = 'Course voted successfully!'
        redirect_back(fallback_location: root_path)
      end
      
    else
      flash[:danger] = 'You need to login to vote!'
      redirect_back(fallback_location: root_path)
    end
  end
  
  def new
    @course = Course.new
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
  
    def set_course
      @course_id = Course.find(params[:id])
    end
  
    def set_course_info
      @categories = Category.all
      @locations = Location.all    
    end
  
  
end
