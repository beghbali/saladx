class Ingredient < ActiveRecord::Base
  attr_protected

  scope :greens, -> { where(category: 'greens') }
  scope :vegetables, -> { where(category: 'vegetables') }
  scope :proteins, -> { where(category: 'protein') }
  scope :available, -> { where('available_servings > 0') }

  def self.categories
    uniq.pluck(:category)
  end
end
