class CreateJoinTableClubUser < ActiveRecord::Migration[5.2]
  def change
    create_join_table :clubs, :users do |t|
      # t.index [:club_id, :user_id]
      # t.index [:user_id, :club_id]
    end
  end
end
