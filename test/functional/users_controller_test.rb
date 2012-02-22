require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails
  
  setup do
    @user = User.create do |u|
      u.email = 'test@example.com'
      u.password = u.password_confirmation = 'test'
    end
    login_user(@user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: {email: 'test2@example.com', password: 'test', password_confirmation: 'test' }
    end

    assert_redirected_to users_path
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: {email: 'test.change@example.com'}
    assert_redirected_to user_path(assigns(:user))
    assert_equal 'test.change@example.com', @user.reload.email
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
