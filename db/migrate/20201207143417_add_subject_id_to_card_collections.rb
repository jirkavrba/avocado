class AddSubjectIdToCardCollections < ActiveRecord::Migration[6.0]
  def change
    add_column :card_collections, :subject_id, :integer, null: true
  end
end
