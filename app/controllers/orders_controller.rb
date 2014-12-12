class OrdersController < ApplicationController
  layout 'consumer'

  def new
    @order = Order.new
    @order.build_recipe
  end

  def create
    @order = Order.new(order_params)
    @order.customer = current_user || User.create(user_params)
    @order.build_recipe(recipe_params)

    if @order.save && @order.payed?
      flash[:notice] = 'Thank you. Your salad will arrive in 20min'
      redirect_to thank_you_order_path(@order)
    else
      render :new
    end
  end

  def thank_you
  end

  private

  def recipe_params
    ActionController::Parameters.new(params[:order].delete(:recipe)).permit(ingredient_ids: [])
  end

  def order_params
    params.required(:order).permit(:phone_number, :recipe_attributes, :street_address, :city, :state, :zip_code, :full_name, :delivery_instructions)
  end

  def user_params
    permitted = ActionController::Parameters.new(stripe_card_token: params[:stripe_card_token],
      phone_number: params[:order][:phone_number], full_name: params[:order][:full_name])
    permitted.permit(:stripe_card_token, :phone_number, :full_name)
  end
end
