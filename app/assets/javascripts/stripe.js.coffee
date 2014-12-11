addInputNames = ->
  $(".card-number").attr "name", "card-number"
  $(".card-cvc").attr "name", "card-cvc"
  $(".card-expiry-year").attr "name", "card-expiry-year"
  $(".card-expiry-month").attr "name", "card-expiry-month"

removeInputNames = ->
  $(".card-number").removeAttr "name"
  $(".card-cvc").removeAttr "name"
  $(".card-expiry-year").removeAttr "name"
  $(".card-expiry-month").removeAttr "name"

submit = (form) ->

  # remove the input field names for security
  # we do this *before* anything else which might throw an exception
  removeInputNames()

  # given a valid form, submit the payment details to stripe
  $(form).find('button[type=submit]').attr "disabled", "disabled"
  Stripe.createToken
    number: $(".card-number").val()
    cvc: $(".card-cvc").val()
    exp_month: $(".card-expiry-month").val()
    exp_year: $(".card-expiry-year").val()
  , (status, response) ->
    if response.error

      # re-enable the submit button
      $(form).find('button[type=submit]').removeAttr "disabled"

      # show the error
      $(".payment-errors").html response.error.message

      # we add these names back in so we can revalidate properly
      addInputNames()
    else

      # token contains id, last4, and card type
      token = response["id"]

      # insert the stripe token
      $('.x-stripe-token').val(token)

      form.submit()
    return

  false

$ ->
  Stripe.setPublishableKey $("[data-stripe-publishable-key]").data('stripe-publishable-key')
  $(".payment").closest('form').on 'submit', (e)->
    e.preventDefault()
    submit(@)

  # adding the input field names is the last step, in case an earlier step errors
  addInputNames()

