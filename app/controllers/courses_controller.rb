class CoursesController < ApplicationController
  before_action :set_course_info, only: [:show, :create, :new, :edit, :update]
  before_action :set_course, only: [:votelike, :votedislike]
  before_action :find_course, only: [:show, :edit, :update, :current_votes_delete, :destroy]
  before_action :user_validate, only: [:edit]
  before_action :vote_validate, only: [:current_votes_delete, :destroy]
  
  def index
    @courses = Course.all
    @users = User.all
  end
  
  def current_votes_delete
    @course.votes.delete_all
    flash[:success] = "Reset Vote for this course successfully!"
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    @course.destroy
    flash[:success] = "Course deleted successfully!"
    redirect_back(fallback_location: root_path)
  end
  
  
  def show
    
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
  
  def edit
  end

  def update
    @course.category_ids = params[:course][:category_ids]
    @course.location_ids = params[:course][:location_ids]
    if @course.update(course_params)  
      flash[:success] = 'Course was successfully updated.'  
      redirect_to @course
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
      redirect_to @course
    else
      render 'new'
    end
  end
  
  private
    def course_params
      params.require(:course).permit(:name,:prerequisite,:description,:user_id,:category_ids,:location_ids,:avatar)
    end
  
    def set_course
      @course_id = Course.find(params[:id])
    end
    
    def find_course
      @course = Course.find(params[:id])
    end
    
    def set_course_info
      @categories = Category.all
      @locations = Location.all    
    end
  
    def user_validate
      if !((logged_in? && current_user == @course.user) || (current_user.isadmin == 1) )
        redirect_to @course
      end
    end
    
    def vote_validate
      if !current_user.isadmin == 1
        redirect_to @course
      end
    end
  
end
