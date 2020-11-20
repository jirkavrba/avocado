require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'index page can be viewed' do
    get '/'
    assert_response :success
  end

  test 'user gets redirected to login if not authenticated' do
    # Log out of the app if authenticated
    sign_out

    get '/dashboard'
    assert_redirected_to sign_in_path
  end

  test 'user can view dashboard if logged in' do
    sign_in_as :normal_user

    get '/dashboard'
    assert_response :success
  end
end
