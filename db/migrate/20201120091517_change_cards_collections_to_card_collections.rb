class ChangeCardsCollectionsToCardCollections < ActiveRecord::Migration[6.0]
  def change
    rename_table :cards_collections, :card_collections
  end
end
