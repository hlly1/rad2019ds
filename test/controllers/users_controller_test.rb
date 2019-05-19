require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(id: 1000, name: "Example User", email: "user.u1@rmit.edu.au", password: "Abcdefghij123.", isadmin: 0)
    get login_path
    post login_path, params: { session: { email:    "user.u1@rmit.edu.au",
                                          password: "Abcdefghij123." } }
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
  end
  
  test "coordinator cannot delete other coordinators" do
    assert_difference 'User.count', 0 do
      delete user_path(@user.id)
    end
  end
  
  test "admin can delete other coordinators" do
    delete logout_path
    @admin = User.create(id: 998, name: "admin", email: "admin.name@rmit.edu.au", password: "Abcdefghij12.", isadmin: 1)
    get login_path
    post login_path, params: { session: { email:    "admin.name@rmit.edu.au",
                                          password: "Abcdefghij12." } }
    assert_difference 'User.count', -1 do
      delete user_path(@user.id)
    end
  end
  

end
