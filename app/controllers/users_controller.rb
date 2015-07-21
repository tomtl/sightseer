class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Welcome #{@user.full_name}! You have registered successfully."
      redirect_to home_path
    else
      flash.now[:error] = "Please fix the following errors."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :full_name, :password)
  end
end