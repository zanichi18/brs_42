class CommentsController < ApplicationController
  before_action :logged_in_user, only: :create
  before_action :load_comment_of_user, only: [:edit, :update, :destroy]

  def index
    get_list_comments
    @comments = @review.comments.created_desc
    @comment = @review.comments.build
    respond_to do |format|
      format.js
    end
  end

  def create
    @comment = current_user.comments.build comment_params
    if @comment.save
      get_list_comments
      @comment = @review.comments.build
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = @comment.errors.full_messages
      redirect_to book_path @review.book
    end
  end

  def edit
    respond_to  do |format|
      format.js
    end
  end

  def update
    if @comment.update_attributes comment_params
      get_list_comments
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = @comment.errors.full_messages
      redirect_to book_path @review.book
    end
  end

  def destroy
    if @comment.destroy
      get_list_comments
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = @comment.errors.full_messages
      redirect_to book_path @review.book
    end
  end

  private
  def comment_params
    params.require(:comment).permit :content, :user_id, :review_id
  end

  def load_comment_of_user
    @comment = current_user.comments.find_by id: params[:id]
    unless @comment
      flash[:danger] = t "controllers.flash.not_permission"
      redirect_to root_url
    end
  end

  def get_list_comments
    @review = Review.find_by id: params[:review_id]
    unless @review
      flash[:danger] = t "controllers.flash.review_not_found"
      redirect_to root_url
    end
    @comments = @review.comments.created_desc
  end
end
