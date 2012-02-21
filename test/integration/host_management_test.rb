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

  test "should see a list of backups for a given host" do
    @host = Host.create!(:name => 'test.example.com')
    @host.backups.create!(:log => 'backup1')
    @host.backups.create!(:log => 'backup2')
    @host.backups.create!(:log => 'backup3')

    visit('/')
    click_link('test.example.com')
    assert_equal host_path(@host), current_path

    assert has_selector?('table.backups')
    assert has_content?('backup1')
    assert has_content?('backup2')
    assert has_content?('backup3')
  end
  
end
