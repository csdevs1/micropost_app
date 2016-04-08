require 'test_helper'

#assert_select: (lets us test for the presence of a particular HTML tag) An assertion that selects elements and makes one or more equality tests. e.g: assert_select "title", "Home | Ruby on Rails Tutorial Sample App" (title should be equal to "Home | Ruby on Rails Tutorial Sample App" )

class StaticPagesControllerTest < ActionController::TestCase
    test "should get home" do
        get :home
        assert_response :success
        assert_select "title", "MicroPost Sample App"
    end
    
    test "should get help" do
        get :help
        assert_response :success
        assert_select "title", "Help | MicroPost Sample App"
    end
    
    test "should get about" do
        get :about
        assert_response :success # Object response should be 200 (OK)
        assert_select "title", "About | MicroPost Sample App"
    end
    
    test "should get contact" do
        get :contact
        assert_response :success # Object response should be 200 (OK)
        assert_select "title", "Contact | MicroPost Sample App"
    end
end
