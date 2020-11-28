class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.integer :card_collection_id

      t.string :title, null: true
      t.text :question, null: true
      t.text :answer, null: true

      t.timestamps
    end
  end
end
