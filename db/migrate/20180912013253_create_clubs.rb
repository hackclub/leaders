class CreateClubs < ActiveRecord::Migration[5.2]
  def change
    create_table :clubs do |t|
      t.integer :api_id
      t.string :name
      t.string :slug

      t.timestamps
    end
  end
end
