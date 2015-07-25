class SessionsController < ApplicationController
  def new
    redirect_to home_path if current_user
  end

  def create
    @user = User.find_by(email: params[:email])

    if user_entered_correct_password?
      add_user_to_session
      flash[:success] = "Welcome #{@user.full_name}! You are signed in."
      redirect_to home_path
    else
      flash[:danger] = "Incorrect email or password."
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_entered_correct_password?
    @user && @user.authenticate(params[:password])
  end

  def add_user_to_session
    session[:user_id] = @user.id
  end
end
