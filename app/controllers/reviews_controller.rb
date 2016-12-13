class ReviewsController < ApplicationController
  before_action :logged_in_user, only: :create
  before_action :correct_user, only: [:edit, :update, :destroy]

  def create
    @review = current_user.reviews.build review_params
    if @review.save
      list_reviews
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = @review.errors.full_messages
      redirect_to book_path @review.book
    end
  end

  def edit
    respond_to  do |format|
      format.js
    end
  end

  def update
    if @review.update_attributes review_params
      list_reviews
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = @review.errors.full_messages
      redirect_to book_path @review.book
    end
  end

  def destroy
    if @review.destroy
      list_reviews
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = @review.errors.full_messages
      redirect_to book_path @review.book
    end
  end

  private
  def review_params
    params.require(:review).permit :content, :user_id, :book_id
  end

  def correct_user
    @review = current_user.reviews.find_by id: params[:id]
    unless @review
      flash[:danger] = t "controllers.flash.not_permission"
      redirect_to root_url 
    end
  end

  def list_reviews
    @reviews = @review.book.reviews.created_desc
      .paginate page: params[:page], per_page: Settings.book.per_page
  end
end
