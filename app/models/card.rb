class Card < ApplicationRecord
  belongs_to :card_collection, primary_key: :collection_id
end
