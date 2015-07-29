class PhotosController < ApplicationController
  before_action :require_user, except: [:show, :index]

  def new
    @sight = Sight.find(params[:sight_id])
    @photo = Photo.new
  end

  def create
    @sight = Sight.find(params[:sight_id])
    @photo = Photo.new(photo_params)
    @photo.user = current_user
    @photo.sight = @sight

    @photo.save
    flash[:success] = "Your photo of #{@photo.sight.name} has been added successfully!"
    render :new
  end

  private

  def photo_params
    params.require(:photo).permit(:description, :image)
  end
end
