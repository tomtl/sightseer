class ForgotPasswordsController < ApplicationController
  def create
    if user = User.find_by(email: params[:email])
      user.generate_token!
      UserMailer.send_forgot_password(user).deliver_now
      redirect_to forgot_password_confirmation_path
    else
      flash[:danger] = "Invalid email."
      redirect_to forgot_password_path
    end
  end
end