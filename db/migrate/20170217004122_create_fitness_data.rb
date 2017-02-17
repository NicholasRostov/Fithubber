class CreateFitnessData < ActiveRecord::Migration[5.0]
  def change
    create_table :fitness_data do |t|
      t.integer :steps
      t.integer :heart_rate
      t.integer :miles
      t.integer :calories
      t.integer :sleep
      t.integer :special

      t.timestamps
    end
  end
end
