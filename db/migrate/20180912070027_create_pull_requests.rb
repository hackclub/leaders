class CreatePullRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :pull_requests do |t|
      t.string :repo
      t.integer :number
      t.belongs_to :subdomain
      t.timestamp :closed_at
      t.timestamp :merged_at

      t.timestamps
    end
  end
end
