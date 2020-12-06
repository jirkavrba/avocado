require 'test_helper'

class CardControllerTest < ActionDispatch::IntegrationTest
  test 'anonymous users cannot manage cards of collection' do
    sign_out

    get card_collection_cards_path(card_collections(:public_owned_by_normal_user))
    assert_redirected_to sign_in_path
  end

  test 'users can manage their collection cards' do
    sign_in_as :normal_user

    card_collection = card_collections(:public_owned_by_normal_user)

    get card_collection_cards_path(card_collection)
    assert_response :success
    assert_select 'h2', "Manage cards of #{card_collection.title}"
  end

  test 'users cannot edit other users collection cards' do
    sign_in_as :normal_user

    get card_collection_cards_path(card_collections(:public_owned_by_admin_user))
    assert_response :forbidden
  end

  test 'admins can manage other users collection cards' do
    sign_in_as :admin_user

    card_collection = card_collections(:public_owned_by_normal_user)

    get card_collection_cards_path(card_collection)
    assert_response :success
    assert_select 'h2', "Manage cards of #{card_collection.title}"
  end

  test 'users cannot add cards to other users collections' do
    sign_in_as :normal_user

    card_collection = card_collections(:public_owned_by_admin_user)

    get new_card_collection_card_path(card_collection)
    assert_response :forbidden

    post card_collection_cards_path(card_collection),
         params: {
           card: {
             title: 'Some title',
             question: 'This is not actually that much important tbh'
           }
         }

    assert_response :forbidden
  end

  test 'admins can add cards to other users collections' do
    sign_in_as :admin_user

    card_collection = card_collections(:public_owned_by_normal_user)

    get new_card_collection_card_path(card_collection)
    assert_response :success

    post card_collection_cards_path(card_collection),
         params: {
           card: {
             title: 'Some title',
             question: 'This is not actually that much important tbh'
           },
           return: true
         }

    assert_redirected_to card_collection_path(card_collection)
  end

  test 'anonymous users can view cards json of public collections' do
    sign_out

    card_collection = card_collections(:public_owned_by_normal_user)

    get card_collection_cards_path(card_collection)
    assert_redirected_to sign_in_path

    # Only json endpoint is allowed to be accessed without login
    get card_collection_cards_path(card_collection, format: :json)
    assert_response :success
  end

  test 'anonymous users cannot view cards json of private collections' do
    sign_out

    card_collection = card_collections(:private_owned_by_normal_user)

    get card_collection_cards_path(card_collection)
    assert_redirected_to sign_in_path

    get card_collection_cards_path(card_collection, format: :json)
    assert_response :forbidden
  end

  test 'signed in users can view cards json of public collections' do
    sign_in_as :normal_user

    card_collection = card_collections(:public_owned_by_admin_user)

    get card_collection_cards_path(card_collection)
    assert_response :forbidden

    get card_collection_cards_path(card_collection, format: :json)
    assert_response :success
  end

  test 'signed in users can view cards json of their private collections' do
    sign_in_as :normal_user

    card_collection = card_collections(:private_owned_by_normal_user)

    get card_collection_cards_path(card_collection)
    assert_response :success

    get card_collection_cards_path(card_collection, format: :json)
    assert_response :success
  end

  test 'admin users can view cards json of any collection' do
    sign_in_as :admin_user

    get card_collection_cards_path(card_collections(:private_owned_by_normal_user))
    assert_response :success

    get card_collection_cards_path(card_collections(:private_owned_by_normal_user), format: :json)
    assert_response :success

    get card_collection_cards_path(card_collections(:public_owned_by_normal_user))
    assert_response :success

    get card_collection_cards_path(card_collections(:public_owned_by_normal_user), format: :json)
    assert_response :success
  end
end

