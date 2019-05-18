require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @lcoation = locations(:one)
    @category = Category.create(id: 1, name:"Web Development")
    @user = User.create(id: 1000, name: "Example User", email: "user.u1@rmit.edu.au", password: "Abcdefghij123.", isadmin: 0)
    #admin user is just for testing
    # @admin = User.create(id: 999, name: "admin", email: "admin.name@rmit.edu.au", password: "Abcdefghij123.", isadmin: 1)
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

  test "all courses listed access" do
    get allcourse_path
    assert_response :success
  end

  test "courses show page access" do
    get course_url(@course.id)
    assert_response :success
  end

  test "courses new page access" do
    get newcourse_path
    assert_response :success
  end

  test "course edited successfully when logged in" do
    assert is_logged_in?
    patch course_path(@course.id), params: { course: { name:  "Capstone Project",
                                        user_id: @user.id, 
                                        prerequisite: "Introduction to Java",
                                        description: "dhigfhiahfahgieadhngajhjlashflashflahdsgdasfgsdgsd"
    } }
    assert_redirected_to course_url(@course)
    assert_not flash.nil?
  end

  test "cannot access edit course page when coordinator is different" do
    delete logout_path
    @user = User.create(id: 1001, name: "Example User2", email: "user.u2@rmit.edu.au", password: "Abcdefghij12.", isadmin: 0)
    get login_path
    post login_path, params: { session: { email:    "user.u2@rmit.edu.au",
                                          password: "Abcdefghij12." } }
    assert is_logged_in?
    get edit_course_path(@course.id)
    
    assert_redirected_to allcourse_path
    # assert flash.empty?
    # p "#{flash.empty?}"
  end

  
  test "cannot access new course page when not logged in" do
    delete logout_path
    get newcourse_path
    assert_redirected_to root_path
  end
  

  
# if (@user == @course.user || @user.isadmin == 1)
#     else
#       assert_redirected_to course_url(@course)
#       assert flash.nil?
#     end
    
    
    








#This is for admin func test
  test "course delete(admin)" do
    if (@user.isadmin == 1)
      assert_difference 'Course.count', -1 do
        delete course_path(@course.id)
      end
    elsif (@user.isadmin == 0)
      assert_difference 'Course.count', 0 do
        delete course_path(@course.id)
      end
    end
  end


end
