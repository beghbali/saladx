class DontRequireEmailPassword < ActiveRecord::Migration
  def change
    change_column :users, :email, :string, null: true, default: ""
    change_column :users, :encrypted_password, :string, null: true, default: ""
  end
end
