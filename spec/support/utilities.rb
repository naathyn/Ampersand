include ApplicationHelper

def sign_in(user)
  visit signin_path
  fill_in "Userame", with: user.name
  fill_in "Password", with: user.password
  click_button "Sign in"
  cookies[:remember_token] = user.remember_token
end
