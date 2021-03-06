class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{@user.full_name}!"
      redirect_to home_path
    else
      flash.now[:danger] = "Please fix the following errors."
      render :new
    end
  end

  def show
    @reviews = @user.reviews.paginate(page: params[:page])
    @visited_sights = @user.visited_sights.paginate(page: params[:page])
    @photos = @user.photos.paginate(page: params[:page], per_page: 10)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your user information has been updated successfully."
      redirect_to home_path
    else
      flash.now[:danger] = "Please fix the following errors."
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :full_name, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
