# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

##Delivery address/google map
browserSupportFlag =  new Boolean();
initialLocation = null;
sf_soma = new google.maps.LatLng(37.7808157, -122.4024182);

renderGmap = ->
  mapOptions = {
    center: sf_soma,
    zoom: 14,
    mapTypeIds: [google.maps.MapTypeId.ROADMAP]
  };
  map = new google.maps.Map(document.getElementById('delivery-address-map'), mapOptions);
  return map


fill_in_address_field = (component)->
  switch component.types[0]
    when 'street_number' then $('#order_street_address').val(component.long_name + ' ' + $('#order_street_address').val())
    when 'route' then $('#order_street_address').val($('#order_street_address').val() + component.long_name)
    when 'locality' then $('#order_city').val(component.long_name)
    when 'administrative_area_level_1' then $('#order_state').val(component.long_name)
    when 'postal_code' then $('#order_zip_code').val(component.long_name)

fill_in_address_fields = (geocode)->
  fill_in_address_field(component) for component in geocode.address_components

drawCurrentLocation = (map, location)->
  geocoder = new google.maps.Geocoder();
  geocoder.geocode {'latLng': location}, (results, status)->
    if (status == google.maps.GeocoderStatus.OK)
      if (results[1])
        map.setZoom(15)
        marker = new google.maps.Marker
          position: location,
          map: map
        $('[data-user-address]').first().val(results[0].formatted_address)
        fill_in_address_fields(results[0])

initializeGmap = ->
  if(navigator.geolocation)
      browserSupportFlag = true;
      navigator.geolocation.getCurrentPosition((position)->
        initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude)
        map = renderGmap()
        map.setCenter(initialLocation);
        drawCurrentLocation(map, initialLocation)
      , ->
        handleNoGeolocation(browserSupportFlag)
      );

  #Browser doesn't support Geolocation
  else
    browserSupportFlag = false
    handleNoGeolocation(browserSupportFlag)


handleNoGeolocation = (errorFlag)->
  initialLocation = sf_soma
  map = renderGmap()
  map.setCenter(initialLocation)

google.maps.event.addDomListener(window, 'load', initializeGmap)


##Nutrition Table
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
