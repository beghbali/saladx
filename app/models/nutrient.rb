class Nutrient < ActiveRecord::Base
  belongs_to :nutr_def, class_name: 'ActiveNutrition::Models::NutrDef', foreign_key: 'Nutr_No'

  scope :by_importance, -> { order(:importance) }
end
