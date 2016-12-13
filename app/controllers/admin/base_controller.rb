class Admin::BaseController < ApplicationController
  before_action :logged_in_user
  before_action :check_admin_permission

  def check_admin_permission
    unless current_user.is_admin?
      flash[:danger] = t "admin.base.denied"
      redirect_to root_url
    end
  end
  
  def logged_in_user
    unless is_logged_in?
      store_location
      flash[:danger] = t "admin.base.no_loggin_error"
      redirect_to login_url
    end
  end
end
