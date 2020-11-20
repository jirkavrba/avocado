require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  test 'users can sign up' do
    post sign_up_path, params: {
      user: {
        username: 'some_username_that_is_not_taken_yet',
        password: 'password'
      }
    }

    assert_redirected_to dashboard_path
  end

  test 'users can view sign up form if not authenticated' do
    sign_out

    get sign_up_path
    assert_response :success
  end

  test 'users are redirected to dashboard if already authenticated' do
    sign_in_as :normal_user

    get sign_up_path
    assert_redirected_to dashboard_path
  end
end
