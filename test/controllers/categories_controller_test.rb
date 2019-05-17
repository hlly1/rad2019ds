require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @c = categories(:Web)
  end
  
  # test "category add successfully" do
  #   get addcategory_path
  #   assert_difference 'Category.count', 1 do
  #   post addcategory_path, params: { category: { name:  "Web Development"} }
  #   end
  #   follow_redirect!
  #   assert_template addcategory_path
  #   assert_not flash.nil?
  # end

end
