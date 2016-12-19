class LikesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @like = current_user.likes.build review_id: params[:review_id]
    if @like.save
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = @like.errors.full_messages
      redirect_to root_url
    end 
  end

  def destroy
    like_to_destroy
    if @like.destroy
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = @like.errors.full_messages
      redirect_to root_url
    end
  end

  private
  def like_to_destroy
    @like = current_user.likes.find_by id: params[:id]
    unless @like
      flash[:danger] = t "controllers.flash.like_not_found"
      redirect_to root_url
    end
  end
end
