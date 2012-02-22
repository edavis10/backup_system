require 'test_helper'

class CreatingBackupTest < ActionDispatch::IntegrationTest
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

  test "should allow creating a new backup on a host using the API" do
    @host = Host.create!(:name => 'test.example.com')

    page.driver.post host_backups_path(@host, :format => "json"), "backup" => {"log" => "The backup was successful"}
    
    assert_equal 1, @host.backups.count
    assert_equal "The backup was successful", @host.backups.first.log
  end
  
end
