ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def sign_out
    delete sign_out_path
  end

  def sign_in_as(name)
    user = users(name)

    post sign_in_path, params: {
      username: user.username,
      password: user.username
    }
  end
end
