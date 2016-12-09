class BooksController < ApplicationController
  before_action :logged_in_user
  
  def index
    @books = Book.order_created_at.paginate page: params[:page],
      per_page: Settings.book.per_page
  end

  def show
    @book = Book.find_by id: params[:id]
    unless @book
      flash[:danger] = t "controller.book.flash.fail"
      redirect_to books_url 
    end
  end
end
