require 'test_helper'

# assert_select: dds the assert_select method for use in Rails functional test cases, which can be used to make assertions on the response HTML of a controller action. 

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
    test "layout links" do
        get root_path
        assert_template 'static_pages/home'
        assert_select "a[href=?]", root_path, count: 2
        assert_select "a[href=?]", help_path
        assert_select "a[href=?]", about_path
        assert_select "a[href=?]", contact_path
        assert_select "a[href=?]", login_path
    end
end
