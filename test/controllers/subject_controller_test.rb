# frozen_string_literal: true

require 'test_helper'

class SubjectControllerTest < ActionDispatch::IntegrationTest
  test 'anonymous users can view subjects' do
    sign_out

    get subjects_path
    assert_response :success
  end

  test 'anonymous user cannot edit subjects' do
    sign_out

    get new_subject_path
    assert_redirected_to sign_in_path

    get edit_subject_path(subjects(:matematika_pro_informatiky))
    assert_redirected_to sign_in_path
  end

  test 'signed in users can view subjects' do
    sign_in_as :normal_user

    get subjects_path
    assert_response :success
  end

  test 'signed in users cannot edit subjects' do
    sign_in_as :normal_user

    get new_subject_path
    assert_response :forbidden

    get edit_subject_path(subjects(:matematika_pro_informatiky))
    assert_response :forbidden
  end

  test 'admin users can view subjects' do
    sign_in_as :admin_user

    get subjects_path
    assert_response :success
  end

  test 'admin users can edit subjects' do
    sign_in_as :admin_user

    get new_subject_path
    assert_response :success

    get edit_subject_path(subjects(:matematika_pro_informatiky))
    assert_response :success
  end
end
