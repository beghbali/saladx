class Recipe < ActiveRecord::Base
  has_many :ingredient, through: :recipe_ingredients
end
