class CreateMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :meetings do |t|
      t.datetime :start_time
      t.integer :attendee_count
      t.belongs_to :club, foreign_key: true

      t.timestamps
    end
  end
end
