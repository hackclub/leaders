class RenameChangeRequestTypeColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :change_requests, :type, :record_type
  end
end
