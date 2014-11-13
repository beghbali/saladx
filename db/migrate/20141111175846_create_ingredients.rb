class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :serving_size
      t.float :available_amount
      t.timestamps
    end
  end
end
