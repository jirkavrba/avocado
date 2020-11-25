class CardCollection < ApplicationRecord
  belongs_to :user
  has_many :cards, foreign_key: :collection_id

  scope :public_collections, -> { where(is_public: true) }

  # @param [User] user
  # @return [ActiveRecord::Relation<CardCollection>]
  def self.visible_for(user)
    if user.nil? || user.is_banned
      public_collections.all
    elsif user.is_admin
      all
    else
      (user.card_collections + public_collections).uniq
    end
  end
end
