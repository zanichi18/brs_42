class Admin::BaseController < ApplicationController
  before_action :logged_in_user, :check_admin_permission

  def check_admin_permission
    unless current_user.is_admin?
      flash[:danger] = t ".denied"
      redirect_to root_url
    end
  end

  def logged_in_user
    unless is_logged_in?
      store_location
      flash[:danger] = t ".warning"
      redirect_to login_url
    end
  end
end
