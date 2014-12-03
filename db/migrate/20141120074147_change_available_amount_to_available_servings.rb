class ChangeAvailableAmountToAvailableServings < ActiveRecord::Migration
  def change
    remove_column :ingredients, :available_amount
    add_column :ingredients, :available_servings, :integer
  end
end
