class SightsController < ApplicationController
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

  def show
    @sight = Sight.find(params[:id])
  end

  private

  def sight_params
    params.require(:sight).permit(:name, :address, :category_id, :description)
  end
end