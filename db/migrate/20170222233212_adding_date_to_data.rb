class AddingDateToData < ActiveRecord::Migration[5.0]
  def change
    add_column :fitness_data, :date, :datetime
  end
end
