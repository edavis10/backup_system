require 'test_helper'

class CreatingBackupTest < ActionDispatch::IntegrationTest
  test "should allow creating a new backup on a host using the API" do
    @host = Host.create!(:name => 'test.example.com')

    backup = {"log" => "The backup was successful"}
    page.driver.post host_backups_path(@host, :format => "json"), backup.to_json
    
    assert_equal 1, @host.backups.count
  end
  
end
