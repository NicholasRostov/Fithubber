class AddingUserId < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :user_id, :string
  end
end
