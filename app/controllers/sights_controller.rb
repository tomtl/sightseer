class SightsController < ApplicationController
  def new
    @sight = Sight.new
  end

  def create
    redirect_to sights_path
  end
end