class Ingredient < ActiveRecord::Base
  attr_protected

  scope :greens, -> { where(category: 'greens') }
  scope :vegetables, -> { where(category: 'vegetables') }
  scope :proteins, -> { where(category: 'protein') }
  scope :available, -> { where('available_servings > 0') }

  #need to convert nutrients based on serving_size ratio to whatever the nutrient definition amount is

  def self.categories
    uniq.pluck(:category)
  end

  def to_nutrition
    to_select_nutrition(:all)
  end

  def to_important_nutrition
    to_select_nutrition(:important)
  end

  def nutrition_facts
    @nutrition_facts ||= begin
      active_nutrient = ActiveNutrition.search(self.name).first
      active_nutrient.present? ? active_nutrient.nutrition_facts.to_hash(by: :nutrition_number) : {}
    end
  end

  def nutrients
    Rails.cache.fetch(['v4', name, 'nutrients', updated_at]) do
      nn = Nutrient.where(Nutr_No: nutrition_facts.keys)
      nn.any? ? nn.each {|n| n.amount = nutrition_facts[n.Nutr_No]; n } : []
    end
  end

  alias_method :all_nutrients, :nutrients

  def important_nutrients
    nutrients.select{ |nutrient| nutrient.importance > Nutrient::IMPORTANCE_LOWER_BOUND }
  end

  private
  def to_select_nutrition(which=:all)
    {
      self.id => send("#{which}_nutrients").reduce({}){ |h, nutrient| nutrient && (h[nutrient.name] = {amount: nutrient.amount, pdv: nutrient.pdv}); h }
    }
  end
end
