class Cooks::OrdersController < ApplicationController

  def index
    #VIN: you need to get the next unfulfilled order and redirect to show (to show that order)
  end

  def show
    #VIN:  you get the order and the view will use it to render the appropriate data in the slim template
  end

  def complete
    #VIN: will find and mark the order as complete and redirect to index
  end

end
