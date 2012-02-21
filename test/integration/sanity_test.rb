require 'test_helper'

class SanityTest < ActionDispatch::IntegrationTest
  test "should load the homepage with capybara" do
    visit('/')
    assert_equal '/', current_path
  end
end
