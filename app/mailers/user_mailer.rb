class UserMailer < ApplicationMailer
  default from: "info@sightseer.com"

  def send_forgot_password(user)
    @user = user
    mail to: user.email, subject: "Please reset your password"
  end
end
