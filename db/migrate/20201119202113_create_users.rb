class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username, unique: true
      t.string :email, unique: true
      t.string :password_digest
      t.boolean :is_admin, default: false
      t.boolean :is_banned, default: false

      t.timestamps
    end
  end
end
