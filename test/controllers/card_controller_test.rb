require 'test_helper'

class CardControllerTest < ActionDispatch::IntegrationTest
  test 'anonymous users cannot manage cards of collection' do
    sign_out

    get card_collection_cards_path(card_collections(:public_owned_by_normal_user))
    assert_redirected_to sign_in_path
  end

  test 'users can manage their collection cards' do
    sign_in_as(:normal_user)

    card_collection = card_collections(:public_owned_by_normal_user)

    get card_collection_cards_path(card_collection)
    assert_response :success
    assert_select 'h2', "Manage cards of #{card_collection.title}"
  end

  test 'users cannot edit other users collection cards' do
    sign_in_as(:normal_user)

    get card_collection_cards_path(card_collections(:public_owned_by_admin_user))
    assert_response :forbidden
  end

  test 'admins can manage other users collection cards' do
    sign_in_as(:admin_user)

    card_collection = card_collections(:public_owned_by_normal_user)

    get card_collection_cards_path(card_collection)
    assert_response :success
    assert_select 'h2', "Manage cards of #{card_collection.title}"
  end
end
