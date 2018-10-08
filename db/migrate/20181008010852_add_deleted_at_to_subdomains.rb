class AddDeletedAtToSubdomains < ActiveRecord::Migration[5.2]
  def change
    add_column :subdomains, :deleted_at, :timestamp
  end
end
