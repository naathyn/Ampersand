class CaptchasController < ApplicationController
  before_filter :signed_in_user

  def index
    @title = "#{current_user.realname} | Captchas (#{current_user.captchas.count})"
    @captchas = current_user.captchas.page(params[:page]).order('created_at DESC')
    @captcha = current_user.captchas.build
  end

  def create
    @captcha = current_user.captchas.build(params[:captcha])
    if @captcha.save
      flash[:success] = "Thanks for sharing! We are eager to read."
      redirect_to captchas_url
    else
      @captchas = []
      render 'index'
    end
  end

  def destroy
    @captcha = Captcha.find(params[:id])
    @captcha.destroy
    flash[:notice] = "Captcha removed. Personally I didn't think it was half bad."
    redirect_to captchas_url
  end
end
