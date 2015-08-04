class SightsController < ApplicationController
  before_action :require_user, only: [:new, :create, :edit, :update]
  before_action :set_sight, only: [:show, :edit, :update]

  def new
    @sight = Sight.new
  end

  def create
    @sight = Sight.new(sight_params)
    if @sight.save
      flash[:success] = "#{@sight.name} has been created successfully!"
      redirect_to sight_path(@sight)
    else
      flash.now[:danger] = "Please fix the following errors."
      render :new
    end
  end

  def index
    @sights = Sight.all
  end

  def show
  end

  def edit
  end

  def update
    if @sight.update(sight_params)
      flash[:success] = "You have updated #{@sight.name} successfully."
      redirect_to sight_path(@sight)
    else
      flash.now[:danger] = "Please fix the following errors."
      render :edit
    end
  end

  def search
  end

  def results
    location = params[:location]
    @sights = Sight.near(location, 25)
  end

  private

  def sight_params
    params.require(:sight).permit(:name, :address, :category_id, :description)
  end

  def set_sight
    @sight = Sight.find(params[:id])
  end
end
