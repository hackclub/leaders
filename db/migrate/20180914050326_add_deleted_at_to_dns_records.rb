class AddDeletedAtToDnsRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :dns_records, :deleted_at, :timestamp
  end
end
