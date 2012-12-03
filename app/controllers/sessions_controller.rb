class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_name(params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = "Glad to see you're back, #{user.name}."
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid username/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    flash[:success] = "You have been signed out.  See you soon!"
    redirect_to root_url
  end
end
