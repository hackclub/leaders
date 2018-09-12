class RenameChangeRequestsToDnsRecords < ActiveRecord::Migration[5.2]
  def change
    rename_table :change_requests, :dns_records

    remove_column :dns_records, :pr_opened_at, :timestamp
    remove_column :dns_records, :pr_merged_at, :timestamp
    remove_column :dns_records, :pr_closed_at, :timestamp
    remove_column :dns_records, :pr_url, :timestamp
  end
end
