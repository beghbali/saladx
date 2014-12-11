class AddStripeCustomerIdAndPhoneNumber < ActiveRecord::Migration
  def change
    add_column :users, :stripe_customer_id, :string
    add_column :orders, :phone_number, :string
    add_column :users, :phone_number, :string
  end
end
