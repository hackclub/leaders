class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :api_id
      t.text :api_access_token
      t.text :session_token
      t.text :email

      t.timestamps
    end
    add_index :users, :api_id, unique: true
    add_index :users, :api_access_token, unique: true
  end
end
