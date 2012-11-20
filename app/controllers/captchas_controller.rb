class CaptchasController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, :only => :destroy

  def index
    @captchas = Captcha.page(params[:page]).order('created_at DESC')
    @captcha = current_user.captchas.build
  end

  def create
    @captcha = current_user.captchas.build(params[:captcha])
    if @captcha.save
      flash[:success] = "Thanks for sharing! I am sure a few are eager to read."
      redirect_to captchas_path
    else
      flash[:error] = "Oops! Something didn't go quite right. Try again?"
      redirect_to captchas_path
    end
  end

  def destroy
    @captcha.destroy
    flash[:success] = "Captcha removed. Personally I didn't think it was half bad."
    redirect_to captchas_path
  end

private

  def correct_user
    @captcha = current_user.captchas.find_by_id(params[:id])
    redirect_to root_url if @captcha.nil?
  end
end
