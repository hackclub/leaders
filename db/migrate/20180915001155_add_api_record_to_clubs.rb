class AddApiRecordToClubs < ActiveRecord::Migration[5.2]
  def change
    add_column :clubs, :api_record, :jsonb
  end
end
