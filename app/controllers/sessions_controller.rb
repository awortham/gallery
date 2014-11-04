class SessionsController < ApplicationController

  skip_before_action :ensure_member

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password]) && user.admin?
      session[:user_id] = user.id
      gflash :now, :success => 'Successfully Logged In'
      redirect_to admin_path(@business.slug)
    elsif user && user.authenticate(params[:password])
      session[:user_id] = user.id
      gflash :now, :success  => 'Successfully Logged In'
      redirect_to :back
    else
      gflash :now, :error => 'Invalid login. Please try again.'
      redirect_to :back
    end
  end

  def destroy
    session.clear
    gflash :now, :success => 'Successfully Logged Out.'
    redirect_to home_path(@business.slug)
  end
end
