class Card < ApplicationRecord
  belongs_to :collection, class_name: 'CardsCollection'
end
