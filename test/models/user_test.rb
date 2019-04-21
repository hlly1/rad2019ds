require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@rmit.edu.au")
  end

  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end
  
  test "name should not be too short" do
    @user.name = "a" * 3
    assert_not @user.valid?
  end
  
  test "email should not be too short" do
    @user.email = "a" * 3
    assert_not @user.valid?
  end

  # test "email validation should accept valid addresses" do
  #   valid_addresses = %w[user@rmit.edu.au USER@RMit.edu.au A_US-ER@RMIt.EDu.au
  #                       first.last@RMIt.EDu.Au alice+bob@RMIT.EDU.AU]
  #   valid_addresses.each do |valid_address|
  #     @user.email = valid_address
  #     assert @user.valid?, "#{valid_address.inspect} should be valid"
  #   end
  # end

  test "Email registeration only open for RMIT staff" do
    invalid_addresses = %w[user@rmit USER@rmit.edu.u A_US-ER@rmit.edu
                         first.last@edu.au alice+bob@baz.au]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert @user.invalid?, "#{invalid_address.inspect} should be valid"
    end
  end
 
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
 
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@RmIt.EdU.aU"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
end
