class OrdersController < ApplicationController
  layout 'consumer'

  def new
    @order = Order.new
    @order.build_recipe
  end

  def create
    @order = Order.new(order_params)
    @order.customer = current_user || User.create(user_params)

    if @order.save && @order.payed?
      flash.now[:info] = 'Thank you. Your salad will arrive in 20min'
    end
    render :new
  end

  private
  def order_params
    params.required(:order).permit(:phone_number, :recipe_attributes, :street_address, :city, :state, :zip_code)
  end

  def user_params
    permitted = ActionController::Parameters.new(stripe_card_token: params[:stripe_card_token], phone_number: params[:order][:phone_number])
    permitted.permit(:stripe_card_token, :phone_number)
  end
end
