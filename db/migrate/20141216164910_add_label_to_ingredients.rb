class AddLabelToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :label, :string
  end
end
