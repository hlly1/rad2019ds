require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  def setup
    get login_path params:{email:'andy.song@rmit.edu.au',password:'Andysong123.'}
    @user = users(:andy)
    @course = Course.new(name: "Java", prerequisite: "Programming 1",
                      description: "Java course")
  end
  
  test "should be valid" do
    assert @course.valid?
  end
  
  test "Name cannot be blank" do
    @course.name = "     "
    assert_not @course.valid?
  end
  
  
  
  
end
