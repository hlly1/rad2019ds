require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @lcoation = locations(:one)
    @category = Category.create(id: 1, name:"Web Development")
    @user = User.create(id: 1000, name: "Example User", email: "user.u1@rmit.edu.au", password: "Abcdefghij123.")
    get login_path
    post login_path, params: { session: { email:    "user.u1@rmit.edu.au",
                                          password: "Abcdefghij123." } }
    @course = Course.new( id: 100, 
                          user_id: @user.id,
                          name:"ABCDEFGHDSJFHJKHFJHJDSF", 
                          prerequisite:"hjhhasdjhafhhahdas",
                          description:"sfhhsajfhashsahdfjsahfjhasdfvhahfjsahjsahdjashdsajkhsad",
                          location_ids: @location,
                          category_ids: @category.id,
                          avatar: ""
                          )
    @course.save!
    # @course = @user.courses.create( id: 100, 
                         
    #                       name:"Rapid Application Dev", 
    #                       prerequisite:"hjhhasdjhafhhahdas",
    #                       description:"sfhhsajfhashsahdfjsahfjhasdfvhahfjsahjsahdjashdsajkhsad",
    #                       location_ids: @location,
    #                       category_ids: @category.id,
    #                       avatar: ""
    #                       )
   

  end

  test "new course created successfully" do
    assert is_logged_in?
    assert_difference 'Course.count' do
    post newcourse_path, params: { course: { name:  "Java ABCDEFGHIJKL",
                                        user_id: @user.id, 
                                        prerequisite: @course.prerequisite,
                                        description: @course.description
    } }
    end
    follow_redirect!
    assert_template 'courses/show'
    assert_not flash.nil?
  end

  test "all courses listed successfully" do
    get allcourse_path
    assert_response :success
  end

  test "courses show page successfully" do
    get course_url(@course.id)
    assert_response :success
  end

  test "course edited successfully" do
    assert is_logged_in?
    patch course_path(@course.id), params: { course: { name:  "Capstone Project",
                                        user_id: @user.id, 
                                        prerequisite: "Introduction to Java",
                                        description: "dhigfhiahfahgieadhngajhjlashflashflahdsgdasfgsdgsd"
    } }
    assert_redirected_to course_url(@course)
    assert_not flash.nil?
  end




end
