class AddEmailOnCheckInToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email_on_check_in, :boolean, null: false, default: false
  end
end
