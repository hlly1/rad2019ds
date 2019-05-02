require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user.u1@rmit.edu.au",
                      password: "Abcdefghij123/")
  end

  test "should be valid" do
    assert @user.valid?
  end
  
  test "Name cannot be blank" do
    @user.name = "     "
    assert_not @user.valid?
  end
  
  test "Email cannot be blank" do
    @user.email = "     "
    assert_not @user.valid?
  end
  
  test "Name is too short" do
    @user.name = "a" * 3
    assert_not @user.valid?
  end
  
  test "Email is too short" do
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
    mixed_case_email = "Foo.foo@RmIt.EdU.aU"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  test "Password cannot be blank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end
  
  # test "Password must contain at least a lowercase letter, a uppercase, a digit, a special character and 8+ characters" do
  #   invalid_passwds = %w[Abc. abcdefghij Abcdefghij ABcdefghij1 ABcdefghij123
  #                       abcdefghij1 abcdefghij. abc12. ABcdefghij1~]
  #   invalid_passwds.each do |invalid_passwd|
  #     @user.password = invalid_passwd
  #     assert @user.invalid?, "#{invalid_passwd.inspect} should be valid"
  #   end    
  # end
  
end
