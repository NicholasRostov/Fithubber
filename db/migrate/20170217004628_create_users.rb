class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.datetime :dob
      t.string :gender
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.integer :zipcode
      t.integer :phone_number
      t.string :education
      t.string :profession
      t.string :organization
      t.string :username
      t.string :password_digest
      t.string :add_token_to_user

      t.timestamps
    end
  end
end
