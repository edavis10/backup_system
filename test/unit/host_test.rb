require 'test_helper'

class HostTest < ActiveSupport::TestCase
  test "should have a name" do
    user = User.create! do |u|
      u.email = 'test@example.com'
      u.password = u.password_confirmation = 'testing'
    end

    host = Host.new do |h|
      h.user = user
    end
    assert host.invalid?, "Host should be invalid without a name"

    host.name = 'This host'
    assert host.valid?, "Host should be valid with a name"
  end
end
