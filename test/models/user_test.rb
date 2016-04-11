require 'test_helper'

# assert true
# This line of code is called an assertion. An assertion is a line of code that evaluates an object (or expression) for expected results. For example, an assertion can check:

# does this value = that value?
# is this object nil?
# does this line of code throw an exception?
# is the user’s password greater than 5 characters?

# assert_not @user.valid? == assert !@user.valid? (both evaluates to false)

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
    def setup
        @user = User.new(name: "Gabriel Pinango", email: "gabriel@example.com", username: "GabrielPinango", password: "123456", password_confirmation: "123456")
    end
    
    test "should be valid" do
        assert @user.valid?
    end
    
    test "name should be present" do
        @user.name = "      "
        assert_not @user.valid?
    end
    
    test "email should be present" do
        @user.email = "      "
        assert_not @user.valid?
    end
    
    test "username should be present" do
        @user.username = "      "
        assert_not @user.valid? # expected result is "not valid" or "false"
    end
    
    test "name should not be too long" do
        # @user.name = "a" * 51
        # assert_not @user.valid?
        
        @user.name = "a a a a a".split(" ")
        if name.length > 4
            assert_not @user.valid?
        end
    end
    
    test "email should not be too long" do
        @user.email = "a" * 244 + "@example.com"
        assert_not @user.valid?
    end
    
    test "username should not be too long" do
        @user.username = "a" * 21
        assert_not @user.valid?
    end
    
    test "email validation should accept valid addresses" do
        valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn] # %w[] is for making array of strings
        valid_addresses.each do |valid_address|
            @user.email = valid_address
            assert @user.valid?, "#{valid_address.inspect} should be valid" # this is a custom error message
        end
    end
    
    test "email validation should reject invalid addresses" do
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com] # %w[] is for making array of strings
        invalid_addresses.each do |invalid_address|
            @user.email = invalid_address
            assert_not @user.valid?, "#{invalid_address.inspect} should be invalid" # this is a custom error message, .inspect eturns a string with a literal representation 
        end
    end
    
    test "email addresses should be unique" do
        duplicate_user = @user.dup # The method here is to make a user with the same email address as @user using @user.dup, which creates a duplicate user with the same attributes.
        duplicate_user.email = @user.email.upcase
        @user.save
        assert_not duplicate_user.valid?
    end
    
    test "password should be present (nonblank)" do
        @user.password = @user.password_confirmation = " " * 6
        assert_not @user.valid?
    end
    
    test "password should have a minimum length" do
        @user.password = @user.password_confirmation = "a" * 5
        assert_not @user.valid?
    end
end
