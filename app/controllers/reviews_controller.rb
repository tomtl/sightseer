class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @sight = Sight.find(params[:sight_id])
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

  private

  def review_params
    params.require(:review).permit(:sight_id, :user_id, :rating, :content)
  end
end
