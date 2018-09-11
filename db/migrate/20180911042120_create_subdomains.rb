class CreateSubdomains < ActiveRecord::Migration[5.2]
  def change
    create_table :subdomains do |t|
      t.integer :club_id
      t.string :name

      t.timestamps
    end
  end
end
