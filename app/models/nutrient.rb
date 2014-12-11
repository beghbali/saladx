class Nutrient < ActiveRecord::Base
  attr_accessor :amount

  IMPORTANCE_LOWER_BOUND = 3
  belongs_to :nutr_def, class_name: 'ActiveNutrition::Models::NutrDef', foreign_key: 'Nutr_No'

  scope :by_importance, -> { order(importance: :desc) }
  scope :important, -> { where('importance > ?', IMPORTANCE_LOWER_BOUND) }

  def pdv
    (amount.to_s.gsub(/,/,'').scan(/[\d\.]+/).first.to_unit/dv.gsub(/,/,'').scan(/[\d\.]+/).first.to_unit) * 100
  end

  def units
    begin
      dv.unit.units
    rescue
      dv.gsub(/[\d,. -]/,'')
    end
  end
end
