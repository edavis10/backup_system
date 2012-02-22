require 'test_helper'

class SanityTest < ActionDispatch::IntegrationTest
  test "should load the login page with capybara" do
    visit('/')
    assert_equal '/login', current_path
  end
end
