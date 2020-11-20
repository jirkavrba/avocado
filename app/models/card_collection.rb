class CardCollection < ApplicationRecord
  belongs_to :user

  # @param [User] user
  # @return [ActiveRecord::Relation<CardCollection>]
  def self.visible_for(user)
    if user.nil? || user.is_banned
      public.all
    elsif user.is_admin
      all
    else
      public.all.merge(user.card_collections)
    end
  end
end
