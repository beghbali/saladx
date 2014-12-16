class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :orders

  accepts_nested_attributes_for :recipe_ingredients

  def as_json(options={})
    attributes.with_indifferent_access.slice(:name).merge(recipe_ingredients: recipe_ingredients.map(&:as_json))
  end
end
