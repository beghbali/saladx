class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.text :boundaries
      t.float :latitude
      t.float :longitude
      t.string :city
      t.string :neighborhood
      t.string :name
      t.timestamps
    end
  end
end
