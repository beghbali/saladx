# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def allow_params(params)
  parameters = ActionController::Parameters.new(params)
  parameters.permit(*params.keys)
end

Ingredient.delete_all

['Baby Field Greens', 'Baby Spinach', 'Baby Arugula', 'Kale', 'butter lettuce', 'iceberg lettuce', 'romaine lettuce'].each do |ingredient|
  Ingredient.create!(allow_params(name: ingredient, serving_size: '1 NLEA', available_servings: [1,2].sample, category: 'greens'))
end

['Grilled Chicken', 'BBQ Chicken', 'Smoked Turkey', 'Marinated Tofu', 'Egg', 'Egg Whites', 'Shredded Tuna'].each do |ingredient|
  Ingredient.create!(allow_params(name: ingredient, serving_size: '100 grams', available_servings: [1,2].sample, category: 'protein'))
end

['Banana Peppers', 'Corn Salsa', 'Broccoli', 'Carrots', 'Chick Peas', 'Cucumbers', 'Mushrooms', 'Red Onions', 'Snap Peas', 'Roasted Peppers',
 'Pickles', 'Cherry Tomatoes', 'Apples', 'Dried Cranberries', 'Golden Raisins', 'Sun Dried Tomatoes ', 'Avacado', 'Beets', 'Cilantro', 'squash',
 'pumpkin', 'heart of palms', 'artichoke'].each do |ingredient|
  Ingredient.create!(allow_params(name: ingredient, serving_size: '50 grams', available_servings: [1,2].sample, category: 'vegetables'))
end

NUTRIENTS = [
  { name: 'Total Fat', importance: 7, dv: '65 g', Nutr_No: 204 },
  { name: 'Saturated Fat', importance: 7, dv: '20 g', Nutr_No: 606 },
  { name: 'Cholesterol', importance: 7, dv: '300 mg', Nutr_No: 601 },
  { name: 'Sodium', importance: 6, dv: '2,400 mg', Nutr_No: 307 },
  { name: 'Potassium', importance: 4, dv: '3,500 mg', Nutr_No: 306 },
  { name: 'Total Carbohydrate', importance: 7, dv: '300 g', Nutr_No: 205 },
  { name: 'Dietary Fiber', importance: 6, dv: '25 g', Nutr_No: 291 },
  { name: 'Protein', importance: 6, dv: '50 g', Nutr_No: 203 },
  { name: 'Vitamin A', importance: 4, dv: '5,000 IU', Nutr_No: 318 },
  { name: 'Vitamin C', importance: 4, dv: '60 mg', Nutr_No: 401 },
  { name: 'Calcium', importance: 5, dv: '1,000 mg', Nutr_No: 301 },
  { name: 'Iron', importance: 5, dv: '18 mg', Nutr_No: 303 },
  { name: 'Vitamin D', importance: 4, dv: '400 IU', Nutr_No: 324 },
  { name: 'Vitamin E', importance: 4, dv: '30 IU', Nutr_No: 323 },
  { name: 'Vitamin K', importance: 4, dv: '80 µg', Nutr_No: 430 },
  { name: 'Thiamin', importance: 2, dv: '1.5 mg', Nutr_No: 404 },
  { name: 'Riboflavin', importance: 3, dv: '1.7 mg', Nutr_No: 405 },
  { name: 'Niacin', importance: 2, dv: '20 mg', Nutr_No: 406 },
  { name: 'Vitamin B6', importance: 4, dv: '2 mg', Nutr_No: 415 },
  { name: 'Folate', importance: 2, dv: '400 µg', Nutr_No: 417 },
  { name: 'Vitamin B12', importance: 4, dv: '6 µg', Nutr_No: 418 },
  { name: 'Pantothenic acid', importance: 1, dv: '10 mg', Nutr_No: 410 },
  { name: 'Phosphorus', importance: 2, dv: '1,000 mg', Nutr_No: 305 },
  { name: 'Magnesium', importance: 2, dv: '400 mg', Nutr_No: 304 },
  { name: 'Zinc', importance: 3, dv: '15 mg', Nutr_No: 309 },
  { name: 'Selenium', importance: 1, dv: '70 µg', Nutr_No: 317 },
  { name: 'Copper', importance: 1, dv: '2 mg', Nutr_No: 312 },
  { name: 'Manganese', importance: 1, dv: '2 mg', Nutr_No: 315 },
]

Nutrient.delete_all

NUTRIENTS.each do |nutrient|
  Nutrient.create!(allow_params(nutrient))
end