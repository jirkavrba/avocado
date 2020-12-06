require 'test_helper'

class CardCollectionControllerTest < ActionDispatch::IntegrationTest
  test 'collections index can be accessed without user session' do
    sign_out
    get card_collections_path
    assert_response :success
  end

  test 'anonymous users can see public collections' do
    sign_out

    get card_collections_path
    assert_select '.card-title', card_collections(:public_owned_by_normal_user).title

    get card_collection_path(card_collections(:public_owned_by_normal_user))
    assert_response :success
  end

  test 'anonymous users cannot see private collections' do
    sign_out

    get card_collections_path
    assert_select '.card-title', { count: 0, text: card_collections(:private_owned_by_normal_user).title }
    assert_select '.card-title', { count: 0, text: card_collections(:private_owned_by_admin_user).title }

    get card_collection_path(card_collections(:private_owned_by_normal_user))
    assert_response :forbidden
    assert_select 'h1', 'Forbidden'
  end

  test 'users can see their private collections' do
    sign_in_as :normal_user

    get card_collections_path
    assert_select '.card-title', { count: 1, text: card_collections(:private_owned_by_normal_user).title }
  end

  test 'anonymous users cannot edit collections' do
    sign_out

    card_collections.each do |collection|
      get edit_card_collection_path(collection)
      assert_redirected_to sign_in_path
    end
  end

  test 'signed in users can edit their collection' do
    sign_in_as :normal_user

    get edit_card_collection_path(card_collections(:public_owned_by_normal_user))
    assert_response :success

    get edit_card_collection_path(card_collections(:private_owned_by_normal_user))
    assert_response :success

    get edit_card_collection_path(card_collections(:private_owned_by_admin_user))
    assert_response :forbidden

    get edit_card_collection_path(card_collections(:public_owned_by_admin_user))
    assert_response :forbidden
  end

  test 'admin users can edit any collection' do
    sign_in_as :admin_user

    card_collections.each do |collection|
      get edit_card_collection_path(collection)
      assert_response :success
    end
  end

  test 'anonymous users cannot create collections' do
    sign_out

    get card_collections_path
    assert_select 'input', { count: 0, value: 'Create a new card collection' }

    get new_card_collection_path
    assert_redirected_to sign_in_path
  end

  test 'signed in users can create collections' do
    sign_in_as :normal_user

    get card_collections_path
    assert_select 'input[value=?]', 'Create a new card collection'

    get new_card_collection_path
    assert_response :success
  end

  test 'anonymous users cannot delete collections' do
    sign_out

    delete card_collection_path(card_collections(:public_owned_by_normal_user))
    assert_redirected_to sign_in_path
  end

  test 'signed in users can delete their collections' do
    sign_in_as :normal_user

    delete card_collection_path(card_collections(:public_owned_by_normal_user))
    assert_redirected_to card_collections_path

    get card_collection_path(card_collections(:public_owned_by_normal_user))
    assert_response :not_found
  end

  test 'signed in users cannot delete collections of other users' do
    sign_in_as :normal_user

    delete card_collection_path(card_collections(:public_owned_by_admin_user))
    assert_response :forbidden
  end
end
