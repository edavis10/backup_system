require 'test_helper'

class HostManagementTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create do |u|
      u.email = 'test@example.com'
      u.password = u.password_confirmation = 'test'
    end
    visit('/')
    assert_equal '/login', current_path
    fill_in "Username", :with => 'test@example.com'
    fill_in "Password", :with => 'test'
    click_button "Login"
  end
  

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
    assert_equal @user, @host.user
  end

  test "should only see the user's hosts" do
    @user2 = User.new do |u|
      u.email = 'test2@example.com'
      u.password = u.password_confirmation = 'testing'
    end
    assert @user2.save
    @host1 = Host.create!(:name => 'test.example.com') {|h| h.user = @user }
    @host2 = Host.create!(:name => 'test2.example.com') {|h| h.user = @user }
    @host_other_user = Host.create!(:name => 'test3.example.com') {|h| h.user = @user2 }

    visit('/')

    assert has_selector?('td', :text => 'test.example.com')
    assert has_selector?('td', :text => 'test2.example.com')
    assert has_no_selector?('td', :text => 'test3.example.com'), "Showing another user's host when it shouldn't be shown"
  end

  test "should see a list of backups for a given host" do
    @host = Host.create!(:name => 'test.example.com') {|h| h.user = @user}
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
