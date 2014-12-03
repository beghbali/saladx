# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def allow_params(params)
  parameters = ActionController::Parameters.new(params)
  parameters.permit(:name, :serving_size, :available_servings, :category)
end

Ingredient.delete_all

['Baby Field Greens', 'Baby Spinach', 'Baby Arugula', 'Kale', 'butter lettuce', 'iceberg lettuce', 'romaine lettuce'].each do |ingredient|
  Ingredient.create!(allow_params(name: ingredient, serving_size: '1 NLEA', available_servings: [1,2].sample, category: 'greens'))
end

['Grilled Chicken', 'BBQ Chicken', 'Smoked Turkey', 'Marinated Tofu', 'Egg', 'Egg Whites', 'Shredded Tuna'].each do |ingredient|
  Ingredient.create!(allow_params(name: ingredient, serving_size: '100 grams', available_servings: [1,2].sample, category: 'protein'))
end

['Banana Peppers', 'Corn Salsa', 'Broccoli', 'Carrots', 'Chick Peas', 'Cucumbers', 'Mushrooms', 'Red Onions', 'Snap Peas', 'Roasted Peppers',
 'Pickles', 'Cherry Tomatoes', 'Apples', 'Dried Cranberries', 'Golden Raisins', 'Sun Dried Tomatoes  ', 'Avacado', 'Beets', 'Cilantro', 'squash',
 'pumpkin', 'heart of palms', 'artichoke'].each do |ingredient|
  Ingredient.create!(allow_params(name: ingredient, serving_size: '50 grams', available_servings: [1,2].sample, category: 'vegetables'))
end

