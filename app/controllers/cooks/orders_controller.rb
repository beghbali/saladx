class Cooks::OrdersController < ApplicationController
  respond_to :json
  skip_before_filter :verify_authenticity_token, only: [:next, :show, :complete]
  before_filter :load_resource, only: [:show, :complete]
  before_filter :load_cook, only: [:next, :show, :complete]

  def next
    @order = Order.unfulfilled.first
    @order.try(:started_by!, @cook)
    respond_with @order
  end

  def index
    @orders = Order.unfulfilled
  end

  def show
    respond_with @order
  end

  def complete
    @order.fulfilled_by!(@cook)
  end

  private
  def load_resource
    @order = Order.find(params[:id])
  end

  def load_cook
    @cook = User.find(params[:cook_id]) rescue nil
  end
end
