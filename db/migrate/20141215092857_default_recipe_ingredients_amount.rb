class DefaultRecipeIngredientsAmount < ActiveRecord::Migration
  def change
    change_column :recipe_ingredients, :amount, :integer, default: 1
  end
end
