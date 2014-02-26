def set_current_user
  john = Fabricate(:user)
  session[:user_id] = john.id
end

def current_user
  User.find(session[:user_id])
end

def clear_current_user
  session[:user_id] = nil
end

def user_signs_in(user)
  visit root_path
  fill_in "username", with: user.username
  click_button "Sign in"
end

