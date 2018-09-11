class CreateChangeRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :change_requests do |t|
      t.timestamp :pr_opened_at
      t.timestamp :pr_merged_at
      t.timestamp :pr_closed_at
      t.string :pr_url
      t.belongs_to :user, foreign_key: true
      t.belongs_to :subdomain, foreign_key: true
      t.string :value
      t.integer :type

      t.timestamps
    end
  end
end
