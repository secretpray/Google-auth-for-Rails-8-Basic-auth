class AddGoogleFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :google_uid, :string
    add_column :users, :google_token, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
