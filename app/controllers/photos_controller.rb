class PhotosController < ApplicationController
  before_action :require_user, except: [:show]
  before_action :set_photo, only: [:show, :edit, :update]
  before_action :require_creator, only: [:edit, :update]

  def new
    @sight = Sight.find(params[:sight_id])
    @photo = Photo.new
  end

  def create
    @sight = Sight.find(params[:sight_id])
    @photo = Photo.new(photo_params)
    @photo.user = current_user
    @photo.sight = @sight

    if @photo.save
      flash[:success] =
        "Your photo of #{@photo.sight.name} has been added successfully!"
      redirect_to sight_path(@sight)
    else
      flash[:danger] = "Please fix the following errors"
      render :new
    end
  end

  def show
    @sight = @photo.sight
  end

  def edit
  end

  def update
    @photo.update(edit_photo_params)
    flash[:success] = "The photo has been updated."
    redirect_to sight_photo_path(@photo.sight, @photo)
  end

  private

  def photo_params
    params.require(:photo).permit(:description, :image)
  end

  def edit_photo_params
    params.require(:photo).permit(:description)
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def require_creator
    if current_user != @photo.user
      flash[:danger] = "You must be the photo creator to do that."
      redirect_to sight_path(@photo.sight)
    end
  end
end
