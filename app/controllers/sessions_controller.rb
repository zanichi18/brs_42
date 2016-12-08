class SessionsController < ApplicationController
  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = t "welcome_message"
      redirect_back_or user
    else
      flash.now[:danger] = t "fail_login"
      render :new
    end
  end

  def destroy
    log_out if is_logged_in?
    redirect_to root_path
  end
end
