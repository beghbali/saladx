class Cooks::CooksController < ApplicationController
  respond_to :json

  def index
    respond_with User.cooks
  end
end