require 'test_helper'

# assert_match method, which can be used either with a string or a regular expression:

# assert_match 'foo', 'foobar'      # true
# assert_match 'baz', 'foobar'      # false
# assert_match /\w+/, 'foobar'      # true
# assert_match /\w+/, '$#!*+@'      # false

class UserMailerTest < ActionMailer::TestCase
    test "account_activation" do
        user = users(:gabriel)
        user.activation_token = User.new_token
        mail = UserMailer.account_activation(user)
        assert_equal "Account activation", mail.subject
        assert_equal [user.email], mail.to
        assert_equal ["noreply@example.com"], mail.from
        assert_match user.name,               mail.body.encoded
        assert_match user.activation_token,   mail.body.encoded
        assert_match CGI::escape(user.email), mail.body.encoded
    end
    
    test "password_reset" do
        user = users(:gabriel)
        user.reset_token = User.new_token
        mail = UserMailer.password_reset(user)
        assert_equal "Password reset", mail.subject
        assert_equal [user.email], mail.to
        assert_equal ["noreply@example.com"], mail.from
        assert_match user.reset_token,        mail.body.encoded
        assert_match CGI::escape(user.email), mail.body.encoded
    end
end
