require 'test_helper'

class HostManagementTest < ActionDispatch::IntegrationTest
  test "should allow creating new hosts" do
    visit('/')
    assert_equal '/', current_path

    click_link "New Host"
    assert_equal '/hosts/new', current_path

    fill_in "Name", :with => 'test.example.com'
    fill_in "Description", :with => 'A web host'
    click_button('Create Host')

    @host = Host.last
    assert_equal host_path(@host), current_path
  end
  
end
