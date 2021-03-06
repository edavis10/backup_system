ENV["RAILS_ENV"] = "test"

begin
  require 'turn/autorun'
  Turn.config.trace = 10
  Turn.config.ansi = true if ENV['CIBUILD'].nil?
rescue LoadError
end

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

require 'capybara/rails'

module BackupSystem
  module CapybaraHelpers
    def sign_in(email, password)
      visit('/')
      assert_equal '/login', current_path
      fill_in 'Username', :with => email
      fill_in 'Password', :with => password
      click_button 'Login'
      assert_equal '/', current_path
    end
  end
end

# Transactional fixtures do not work with Selenium tests, because Capybara
# uses a separate server thread, which the transactions would be hidden
# from. We hence use DatabaseCleaner to truncate our test database.
DatabaseCleaner.strategy = :truncation

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  include BackupSystem::CapybaraHelpers
  # Stop ActiveRecord from wrapping tests in transactions
  self.use_transactional_fixtures = false

  teardown do
    DatabaseCleaner.clean       # Truncate the database
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver
  end
end
