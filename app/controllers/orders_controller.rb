class OrdersController < ApplicationController
  layout 'consumer'

  def new
    @order = Order.new
  end

  def create
    stripe_card_token = params.delete(:stripe_card_token)
    @order = Order.new(params[:order])
    @order.customer = current_user || User.create(stripe_card_token: stripe_card_token, phone_number: params[:order][:phone_number])

    if @order.save && @order.payed?
      flash.now[:info] = 'Thank you. Your salad will arrive in 20min'
    end
  end

end
