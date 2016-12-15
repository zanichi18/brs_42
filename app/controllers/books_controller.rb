class BooksController < ApplicationController
  before_action :logged_in_user
  before_action :load_book, only: :show
  
  def index
    @books = Book.order_created_at.paginate page: params[:page],
      per_page: Settings.book.per_page
  end

  def show
    @mark = Mark.find_by user_id: current_user.id, book_id: params[:id]
    unless @mark 
      @mark= Mark.new user_id: current_user.id, book_id: params[:id]
      @mark.save
    end
  end

  private 
  def load_book
    @book = Book.find_by id: params[:id]
    unless @book
      flash[:danger] = t "controller.book.flash.fail"
      redirect_to books_url 
    end
  end
end
