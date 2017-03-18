class ChangeToDistance < ActiveRecord::Migration[5.0]
  def change
    rename_column :fitness_data, :miles, :distance
  end
end
