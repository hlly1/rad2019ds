require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def set
    @user = users(:andy)
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
  end

end
