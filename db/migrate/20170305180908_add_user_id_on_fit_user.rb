class AddUserIdOnFitUser < ActiveRecord::Migration[5.0]
  def change
    add_column :fit_users, :user_id, :integer
  end
end
