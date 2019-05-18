require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  def setup
    @location = Location.create(name: "14.10.31")
  end

  test "Name cannot be blank" do
    @location.name = "     "
    assert_not @location.valid?
  end

  test "Name should be unique" do
    location1 = Location.new(name: "14.10.31")
    assert_not location1.save
  end
end
