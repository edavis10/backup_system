require 'test_helper'

class HostTest < ActiveSupport::TestCase
  test "should have a name" do
    host = Host.new
    assert host.invalid?, "Host should be invalid without a name"

    host.name = 'This host'
    assert host.valid?, "Host should be valid with a name"
  end
end
