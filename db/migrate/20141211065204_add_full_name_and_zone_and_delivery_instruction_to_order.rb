class AddFullNameAndZoneAndDeliveryInstructionToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :full_name, :string
    add_column :users, :full_name, :string
    add_column :orders, :zone, :string
    add_column :orders, :delivery_instructions, :text
  end
end
