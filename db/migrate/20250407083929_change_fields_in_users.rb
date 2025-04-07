class ChangeFieldsInUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :google_uid
    remove_column :users, :google_token
    add_column :users, :provider, :string
    add_column :users, :provider_uid, :string
    add_column :users, :provider_token, :string
  end
end
