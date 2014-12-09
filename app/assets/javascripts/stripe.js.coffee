Stripe.setPublishableKey $("[data-stripe-publishable-key]").data('stripe-publishable-key')

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
  $(form["submit-button"]).attr "disabled", "disabled"
  Stripe.createToken
    number: $(".card-number").val()
    cvc: $(".card-cvc").val()
    exp_month: $(".card-expiry-month").val()
    exp_year: $(".card-expiry-year").val()
  , (status, response) ->
    if response.error

      # re-enable the submit button
      $(form["submit-button"]).removeAttr "disabled"

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
  # add custom rules for credit card validating
  jQuery.validator.addMethod "cardNumber", Stripe.validateCardNumber, "Please enter a valid card number"
  jQuery.validator.addMethod "cardCVC", Stripe.validateCVC, "Please enter a valid security code"
  jQuery.validator.addMethod "cardExpiry", (->
    Stripe.validateExpiry $(".card-expiry-month").val(), $(".card-expiry-year").val()
  ), "Please enter a valid expiration"

  # We use the jQuery validate plugin to validate required params on submit
  $(".payment").closest('form').validate
    submitHandler: submit
    rules:
      "card-cvc":
        cardCVC: true
        required: true

      "card-number":
        cardNumber: true
        required: true

      "card-expiry-year": "cardExpiry" # we don't validate month separately


  # adding the input field names is the last step, in case an earlier step errors
  addInputNames()

