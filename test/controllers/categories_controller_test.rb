require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  
  test "should get new" do
    get addcategory_path
    assert_response :success
  end

end
