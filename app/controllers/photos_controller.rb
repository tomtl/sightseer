class PhotosController < ApplicationController
  before_action :require_user, except: [:show, :index]

  def new
    @sight = Sight.find(params[:sight_id])
    @photo = Photo.new
  end
end