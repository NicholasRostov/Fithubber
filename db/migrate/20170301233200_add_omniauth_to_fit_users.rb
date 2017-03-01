class AddOmniauthToFitUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :fit_users, :provider, :string
    add_column :fit_users, :uid, :string
  end
end
