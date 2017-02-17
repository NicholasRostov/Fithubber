class RenameFriendship < ActiveRecord::Migration[5.0]
  def change
    rename_table :frienships, :friendships
  end
end
