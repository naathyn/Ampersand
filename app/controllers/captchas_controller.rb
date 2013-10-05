class CaptchasController < ApplicationController
  before_filter :signed_in_user
  before_filter :captcha_user, only: :destroy

  def create
    @captcha = current_user.captchas.build(captcha_params)
    if @captcha.save
      flash[:success] = "Thanks for sharing!"
      redirect_to captchas_user_url(current_user)
    else
      @title = "Please try again."
      @captchas = current_user.captchas.page(params[:page])
      render :index
    end
  end

  def destroy
    @captcha.destroy
    redirect_to captchas_user_url(current_user),
      notice: "Captcha' removed. Personally I didn't think it was half bad!"
  end

private

  def captcha_params
    params.require(:captcha).permit(:content)
  end

protected

  def captcha_user
    @captcha = current_user.captchas.find_by_id(params[:id])
    redirect_to :root unless @captcha
  end
end
