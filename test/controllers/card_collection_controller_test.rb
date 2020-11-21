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

  test 'Anonymous users cannot see public collections' do
    sign_out

    get card_collections_path
    assert_select 'p', { count: 0, text: card_collections(:private_owned_by_normal_user).title }
    assert_select 'p', { count: 0, text: card_collections(:private_owned_by_admin_user).title }

    get card_collection_path(card_collections(:private_owned_by_normal_user))
    assert_response :forbidden
  end

  # TODO: test editing, adding cards etc. when implemented
end
