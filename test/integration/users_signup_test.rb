require 'test_helper'

# assert_no_difference: Assertion that the numeric result of evaluating an expression is not changed before and after invoking the passed in block. This is equivalent to recording the user count, posting the data, and verifying that the count is the same:

# before_count = User.count
# post users_path, ...
# after_count  = User.count
# assert_equal before_count, after_count

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
    def setup
        ActionMailer::Base.deliveries.clear
    end
    
    test "invalid signup information" do
        get signup_path # Not necessary, but this is to check that the signup page renders without error.
        assert_no_difference 'User.count' do
            post users_path, user: { name: "", 
                                    email: "user@invalid",
                                    username: "",
                                    password: "123",
                                    password_confirmation: "125" }
        end
        assert_template 'users/new' # To check that a failed submission renders the 'new action'
    end
    
    test "valid signup information" do
        get signup_path 
        assert_difference 'User.count', 1 do # second argument (1) is optional
            post users_path, user: { name: "Example User", 
                                    email: "user@example.com",
                                    username: "Username",
                                    password: "password",
                                    password_confirmation: "password" }
        end
        # assert_redirected_to '/users/1046959424' # '/users/697925615' # To check that a valid submission redirects to the 'user page'
        # assert is_logged_in?
        assert_equal 1, ActionMailer::Base.deliveries.size
        user = assigns(:user)
        assert_not user.activated?
        # Try to log in before activation.
        log_in_as(user)
        assert_not is_logged_in?
        # Invalid activation token
        get edit_account_activation_path("invalid token")
        assert_not is_logged_in?
        # Valid token, wrong email
        get edit_account_activation_path(user.activation_token, email: 'wrong')
        assert_not is_logged_in?
        # Valid activation token
        get edit_account_activation_path(user.activation_token, email: user.email)
        assert user.reload.activated?
        follow_redirect!
        assert_template 'users/show'
        assert is_logged_in?
        
    end
end
