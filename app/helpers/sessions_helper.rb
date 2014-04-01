module SessionsHelper

  def sign_in(user)
    user.increment!(:sign_in_count)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def current_user
    @current_user ||= User.find_by(remember_token: cookies[:remember_token])
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in?
    !!current_user
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to :signin, notice: "Please sign in."
    end
  end

  def return_or_redirect_to(page)
    redirect_to(session[:return_to] || page)
    session.delete(:return_to)
  end

  def sign_out
    current_user.update_attribute(:remember_token, User.secure_new_token)
    cookies.delete(:remember_token)
    self.current_user = nil
  end
end
