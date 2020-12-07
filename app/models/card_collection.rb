class CardCollection < ApplicationRecord
  belongs_to :user
  belongs_to :subject
  has_many :cards

  scope :public_collections, -> { where(is_public: true) }

  # @param [User] user
  # @return [ActiveRecord::Relation<CardCollection>]
  def self.visible_for(user)
    if user.nil? || user.is_banned
      public_collections
    elsif user.is_admin
      all
    else
      where(is_public: true).or(where(user_id: user.id))
    end
  end
end
