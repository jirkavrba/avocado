class CreateSubjects < ActiveRecord::Migration[6.0]
  def change
    create_table :subjects do |t|
      t.string :code, unique: true
      t.string :title

      t.timestamps
    end
  end
end
