class SessionsController < ApplicationController
  include Greeter

  def new
    if signed_in?
      redirect_to user_url(current_user), notice: "You are already signed in!"
    else
      @title = "Sign in"
    end
  end

  def create
    user = User.find_by_name(params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = "#{say_hello}, #{user.username}!"
      return_or_redirect_to user
    else
      @title = "Please try again."
      flash.now[:error] = "Invalid username/password combination"
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to :root, notice: "You have been signed out. #{say_goodbye}"
  end
end
