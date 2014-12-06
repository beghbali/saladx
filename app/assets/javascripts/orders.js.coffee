# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

updateNutrientPdv = (existing_nutrient, nutrient_data, operator)->
  pdv = $(existing_nutrient).find('.pdv')
  existing_pdv = parseInt(pdv.text()) || 0
  new_pdv = nutrient_data['pdv'] || 0
  updated_pdv = eval(existing_pdv + operator + new_pdv)
  pdv.text(Math.round(updated_pdv) + '%')

updateNutrientAmount = (existing_nutrient, nutrient_data, operator)->
  amount = $(existing_nutrient).find('.amount')
  existing_amount = parseInt(amount.text()) || 0
  new_amount = nutrient_data['amount'] || 0
  updated_amount = eval(existing_amount + operator + new_amount)
  amount.text(Math.round(updated_amount, 1) + ' ' + amount.data('units'))

updateNutrient = (existing_nutrient, nutrient_data, operator)->
  console.log(existing_nutrient)
  updateNutrientAmount(existing_nutrient, nutrient_data, operator)
  updateNutrientPdv(existing_nutrient, nutrient_data, operator)

findAndUpdateNutrient = (nutrient_name, nutrient_data, operator)->
  updateNutrient(existing_nutrient, nutrient_data, operator) for existing_nutrient in $('.nutrition-facts > ul li') when $(existing_nutrient).find(':first').text() == nutrient_name

addNutrientsFor = (chosen_ingredient, nutrition_number)->
  nutrients = $('.nutrition-facts').data('available-nutritions')[nutrition_number]
  findAndUpdateNutrient(nutrient_name, nutrient_data, '+') for nutrient_name, nutrient_data of nutrients

removeNutrientsFor = (chosen_ingredient, nutrition_number)->
  nutrients = $('.nutrition-facts').data('available-nutritions')[nutrition_number]
  findAndUpdateNutrient(nutrient_name, nutrient_data, '-') for nutrient_name, nutrient_data of nutrients

removeIngredient = (chosen_ingredient, nutrition_number)->
  ingredient.remove() for ingredient in $('.nutrition-facts ul.ingredients').children() when $(ingredient).text() == chosen_ingredient
  removeNutrientsFor(chosen_ingredient, nutrition_number)

addIngredient = (chosen_ingredient, nutrition_number)->
  $('<li>').text(chosen_ingredient).appendTo($('.nutrition-facts ul.ingredients'))
  addNutrientsFor(chosen_ingredient, nutrition_number)

$ ->
  $('.order input[type=checkbox]').on 'change', ->
    chosen_ingredient = $(@).parent().text()
    nutrition_number = $(@).val()

    if @.checked
       addIngredient(chosen_ingredient, nutrition_number)
    else
      removeIngredient(chosen_ingredient, nutrition_number)
