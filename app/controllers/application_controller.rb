class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    unless is_logged_in?
      store_location
      flash[:danger] = t "not_logged_in"
      redirect_to login_url
    end
  end

  def set_relationship user
    unless !is_logged_in? || current_user.is_user?(user)
      if current_user.is_following? user
        @relationship = current_user.active_relationships.find_by followed_id: user.id
      else
        @relationship = current_user.active_relationships.build
      end
    end
  end
end
