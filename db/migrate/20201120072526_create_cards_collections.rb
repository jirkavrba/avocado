class CreateCardsCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :cards_collections do |t|
      t.integer :user_id
      t.string :title, null: true
      t.boolean :is_public, default: false

      t.timestamps
    end
  end
end
