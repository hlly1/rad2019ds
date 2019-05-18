require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.create(name: "Web Development")
  end

  test "Name cannot be blank" do
    @category.name = "     "
    assert_not @category.valid?
  end

  test "Name should be unique" do
    category1 = Category.new(name: "Web Development")
    assert_not category1.save
  end

end
