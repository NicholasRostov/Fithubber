class ChangeDate < ActiveRecord::Migration[5.0]
  def change
    change_column :fitness_data, :date, :string
  end
end
