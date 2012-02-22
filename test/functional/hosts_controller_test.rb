require 'test_helper'

class HostsControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails
  
  setup do
    @user = User.create do |u|
      u.email = 'test@example.com'
      u.password = u.password_confirmation = 'test'
    end
    login_user(@user)
    @host = Host.create(:name => 'test', :description => 'test host') do |host|
      host.user = @user
    end
    login_user @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hosts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create host" do
    assert_difference('Host.count') do
      post :create, host: {:name => 'test2', :description => 'test host'}
    end

    assert_redirected_to host_path(assigns(:host))
    assert_equal @user, assigns(:host).user
  end

  test "should show host" do
    get :show, id: @host
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @host
    assert_response :success
  end

  test "should update host" do
    put :update, id: @host, host: {:name => 'new name'}
    assert_redirected_to host_path(assigns(:host))
    assert_equal 'new name', @host.reload.name
  end

  test "should destroy host" do
    assert_difference('Host.count', -1) do
      delete :destroy, id: @host
    end

    assert_redirected_to hosts_path
  end
end
