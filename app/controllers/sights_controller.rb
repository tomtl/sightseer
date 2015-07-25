class SightsController < ApplicationController
  before_action :require_user, except: [:show, :index]

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
    @sight = Sight.find(params[:id])
    @reviews = @sight.reviews
  end

  def edit
    @sight = Sight.find(params[:id])
  end

  def update
    @sight = Sight.find(params[:id])
    if @sight.update(sight_params)
      flash[:success] = "You have updated #{@sight.name} successfully."
      redirect_to sight_path(@sight)
    else
      flash.now[:danger] = "Please fix the following errors."
      render :edit
    end
  end

  private

  def sight_params
    params.require(:sight).permit(:name, :address, :category_id, :description)
  end
end
