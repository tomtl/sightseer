def set_current_user(user = nil)
  session[:user_id] = Fabricate(:user).id
end