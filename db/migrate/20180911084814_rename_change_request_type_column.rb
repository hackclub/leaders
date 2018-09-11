class RenameChangeRequestTypeColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :change_request, :type, :record_type
  end
end
