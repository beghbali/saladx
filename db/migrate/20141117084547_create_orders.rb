class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :recipe
      t.integer :customer_id
      t.string :street_address
      t.string :city
      t.string :state, default: 'CA'
      t.string :zip_code
      t.float :latitude
      t.float :longitude
      t.string :stripe_charge_id
      t.datetime :ordered_at
      t.datetime :fulfilled_at
      t.integer :cook_id
      t.datetime :pickedup_at
      t.datetime :delivered_at
      t.integer :courier_id
      t.timestamps
    end
  end
end
