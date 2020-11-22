require 'test_helper'

class CardCollectionControllerTest < ActionDispatch::IntegrationTest
  test 'Collections index can be accessed without user session' do
    sign_out
    get card_collections_path
    assert_response :success
  end

  test 'Anonymous users can see public collections' do
    sign_out

    get card_collections_path
    assert_select 'p', card_collections(:public_owned_by_normal_user).title

    get card_collection_path(card_collections(:public_owned_by_normal_user))
    assert_response :success
  end

  test 'Anonymous users cannot see private collections' do
    sign_out

    get card_collections_path
    assert_select 'p', { count: 0, text: card_collections(:private_owned_by_normal_user).title }
    assert_select 'p', { count: 0, text: card_collections(:private_owned_by_admin_user).title }

    get card_collection_path(card_collections(:private_owned_by_normal_user))
    assert_response :forbidden
    assert_select 'h1', 'Forbidden'
  end

  test 'Users can see their private collections' do
    sign_in_as :normal_user

    get card_collections_path
    assert_select 'p', { count: 1, text: card_collections(:private_owned_by_normal_user).title }
  end

  test 'Anonymous users cannot edit collections' do
    sign_out

    card_collections.each do |collection|
      get edit_card_collection_path(collection)
      assert_redirected_to sign_in_path
    end
  end

  test 'Signed in users can edit their collection' do
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

  test 'Admin users can edit any collection' do
    sign_in_as :admin_user

    card_collections.each do |collection|
      get edit_card_collection_path(collection)
      assert_response :success
    end
  end

  # TODO: test adding cards etc. when implemented
end
