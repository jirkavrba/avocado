require 'test_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest
  test 'users can sign in' do
    post sign_in_path, params: {
      username: :normal_user,
      password: :normal_user
    }

    assert_redirected_to dashboard_path
  end

  test 'users are redirected if already authenticated' do
    sign_in_as :normal_user

    get sign_in_path
    assert_redirected_to dashboard_path
  end

  test 'users can view sign in form if not authenticated' do
    sign_out

    get sign_in_path
    assert_response :success
  end
end
