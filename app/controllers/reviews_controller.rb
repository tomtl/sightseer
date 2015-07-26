class ReviewsController < ApplicationController
  before_action :require_user
  before_action :require_creator, only: [:edit, :update]
  before_action :set_sight, only: [:create, :edit]
  before_action :set_review, only: [:edit, :update]

  def create
    @review = @sight.reviews.build(review_params.merge!(creator: current_user))

    if @review.save
      flash[:success] = "Your review of #{@sight.name} has been added."
      redirect_to @sight
    else
      @reviews = @sight.reviews.reload
      flash.now[:danger] = "Please fix the following errors."
      render "sights/show"
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      flash[:success] = "Your review of #{@review.sight.name} has been updated."
      redirect_to sight_path(@review.sight)
    else
      flash.now[:danger] = "Please fix the following errors."
      render :edit
    end
  end

  private

  def review_params
    params.require(:review).permit(:sight_id, :user_id, :rating, :content)
  end

  def set_sight
    @sight = Sight.find(params[:sight_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def require_creator
    unless current_user && current_user == Review.find(params[:id]).creator
      flash[:danger] = "You do not have access to that."
      @sight = Sight.find(params[:sight_id])
      redirect_to @sight
    end
  end
end
