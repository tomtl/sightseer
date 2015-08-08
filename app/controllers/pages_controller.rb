class PagesController < ApplicationController
  def front
    @sights = Sight.all
  end
end