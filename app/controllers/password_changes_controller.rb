class PasswordChangesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def create
    user = current_user
    old_password = params[:password][:old_password]
    new_password = params[:password][:new_password]
    confirm_password = params[:password][:confirm_password]
    if user.authenticate(old_password)
      if new_password == confirm_password
        if user.update_attributes(password: new_password,
          password_confirmation: confirm_password)
          flash[:success] = t ".password_success"
          redirect_to user_path user
        else
          flash[:danger] = t ".password_less_than_6_characters"
          redirect_to password_url
        end
      else
        flash[:danger] = t ".password_not_duplicate"
        redirect_to password_url
      end
    else
      flash[:danger] = t ".password_wrong"
      redirect_to password_url
    end
  end
end
