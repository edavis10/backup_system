require 'test_helper'

class CreatingBackupTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create do |u|
      u.email = 'test@example.com'
      u.password = u.password_confirmation = 'test'
    end
  end

  test "should allow creating a new backup on a host using the API" do
    sign_in('test@example.com', 'test')
    
    @host = Host.create!(:name => 'test.example.com') {|h| h.user = @user }

    page.driver.post host_backups_path(@host, :format => "json"), "backup" => {"log" => "The backup was successful"}
    
    assert_equal 1, @host.backups.count
    assert_equal "The backup was successful", @host.backups.first.log
  end
  
end
