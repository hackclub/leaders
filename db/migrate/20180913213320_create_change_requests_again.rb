class CreateChangeRequestsAgain < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')

    create_table :change_requests do |t|
      t.belongs_to :pull_request
      t.belongs_to :dns_record
      t.hstore :changes_hash

      t.timestamps
    end
  end
end
