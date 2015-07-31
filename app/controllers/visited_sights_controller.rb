class VisitedSightsController < ApplicationController
  before_action :require_user
  before_action :require_list_owner, only: [:destroy]

  def create
    @sight = Sight.find(params[:sight_id])
    @user = current_user

    @visited_sight = VisitedSight.new(user: @user, sight: @sight)
    if @visited_sight.save
      flash[:success] = "#{@sight.name} added to your list of sights visited"
    else
      flash[:danger] = "You already have this sight on your list"
    end
    @reviews = @sight.reviews
    render "sights/show"
  end

  def index
    @user = User.find(params[:user_id])
    @visited_sights = @user.visited_sights
  end

  def destroy
    @visited_sight = VisitedSight.find(params[:id])
    @visited_sight.destroy
    flash.now[:success] = "The sight has been removed from your list."
    redirect_to user_visited_sights_path(user_id: current_user.id)
  end

  private

  def require_list_owner
    visited_sights_list_owner = User.find(params[:user_id])

    if current_user != visited_sights_list_owner
      flash[:danger] = "You are not allowed to do that."
      redirect_to home_path
    end
  end
end
