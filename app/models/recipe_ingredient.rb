class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient

  def as_json(options={})
    attributes.with_indifferent_access.slice(:amount).merge(ingredient: ingredient.as_json)
  end
end
