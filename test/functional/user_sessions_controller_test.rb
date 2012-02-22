require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails

  setup do
    @user = User.create do |u|
      u.email = 'test@example.com'
      u.password = u.password_confirmation = 'test'
    end
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should post create with valid authentication" do
    post :create, :username => 'test@example.com', :password => 'test'
    assert_response :redirect
    assert_redirected_to root_path
    assert_equal "Login successful.", flash[:notice]
  end

  test "should post create with invalid authentication" do
    post :create, :username => 'fail@example.com', :password => 'test'
    assert_response :success
    assert_equal "Login failed.", flash[:alert]
  end

  test "should logout" do
    login_user
    get :destroy
    assert_redirected_to :login
    assert_equal "Logged out!", flash[:notice]
  end

end
