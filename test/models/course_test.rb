require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  def setup
    @user = users(:andy)
    @course = courses(:rad)
  end
  
  test "Name cannot be blank" do
    @course.name = "     "
    assert_not @course.valid?
  end
  
  test "Prerequisite cannot be blank" do
    @course.prerequisite = "     "
    assert_not @course.valid?
  end

  test "Description cannot be blank" do
    @course.description = "     "
    assert_not @course.valid?
  end

  test "Name is too short" do
    @course.name = "a" * 9
    assert_not @course.valid?
  end
  
  test "Prerequisite is too short" do
    @course.prerequisite = "a" * 9
    assert_not @course.valid?
  end

  test "Description is too short" do
    @course.description = "a" * 29
    assert_not @course.valid?
  end
  
  test "course name should be unique" do
    duplicate_course = @course.dup
    duplicate_course.name = @course.name.upcase
    @course.save
    assert_not duplicate_course.valid?
  end  
  
end
