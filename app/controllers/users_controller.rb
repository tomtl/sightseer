class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Welcome #{@user.full_name}!"
      redirect_to home_path
    else
      flash.now[:danger] = "Please fix the following errors."
      render :new
    end
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
