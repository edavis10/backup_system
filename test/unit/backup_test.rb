require 'test_helper'

class BackupTest < ActiveSupport::TestCase
  test "should require a host" do
    backup = Backup.new
    assert backup.invalid?, "Backup should be invalid without a host"
    assert backup.errors[:host_id].any?, "Backup without a host should have errors"

    host = Host.create(:name => 'localhost')
    backup.host = host
    assert backup.valid?, "Backup with a host should be valid"
  end

  test "should allow searching" do
    host = Host.create(:name => 'localhost')
    backup1 = Backup.create!(:host => host, :log => "Unique and similar content")
    backup2 = Backup.create!(:host => host, :log => "New and similar content")
    backup3 = Backup.create!(:host => host, :log => "Pretty and similar content")

    assert_equal [backup1], Backup.search("Unique")
    assert_equal [backup2], Backup.search("new")
    assert_equal [backup1, backup2, backup3], Backup.search("similar content")
  end
end
