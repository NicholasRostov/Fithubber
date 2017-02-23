class AddingUserIdToData < ActiveRecord::Migration[5.0]
  def change
    add_column :fitness_data, :user_id, :integer
  end
end
