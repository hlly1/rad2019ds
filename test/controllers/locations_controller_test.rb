require 'test_helper'

class LocationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(id: 1000, name: "Example User", email: "user.u1@rmit.edu.au", password: "Abcdefghij123.", isadmin: 0)
    get login_path
    post login_path, params: { session: { email:    "user.u1@rmit.edu.au",
                                          password: "Abcdefghij123." } }
  end
  
  test "cannot access category creating when not logged in" do
    delete logout_path
    #access the page
    get addlocation_path
    assert_redirected_to root_path
    assert_not flash.nil?
    #or post data to action in some way
    assert_difference 'Location.count', 0 do
      post addlocation_path, params: { location: { name:  "Location Test"} }
    end
  end
  
  
  test "category create successfully" do
    get addlocation_path
    assert_difference 'Location.count', 1 do
      post addlocation_path, params: { location: { name:  "Location Test2"} }
    end
    assert_redirected_to addlocation_path
    assert_not flash.nil?
  end

end
