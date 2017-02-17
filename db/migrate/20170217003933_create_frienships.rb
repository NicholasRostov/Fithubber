class CreateFrienships < ActiveRecord::Migration[5.0]
  def change
    create_table :frienships do |t|
      t.integer :userd_id
      t.integer :friend_id

      t.timestamps
    end
  end
end
