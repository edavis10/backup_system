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

end
