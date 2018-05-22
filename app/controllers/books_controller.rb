class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :load_book, only: :show

  def show
    @review = Review.new
    @mark = Mark.new
    unless @book
      flash[:danger] = "Book not found!"
      redirect_to books_path
    end
  end

  def index
    @q = Book.ransack params[:q]
    @q.sorts = Settings.default_sort if @q.sorts.empty?
    @books = @q.result
      .joins(:category)
      .page(params[:page]).per Settings.per_page
    @q.build_condition if @q.conditions.empty?
    @q.build_sort if @q.sorts.empty?
  end

  private
  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:error] = "Cannot find book with id #{params[:id]}"
    redirect_to root_url
  end
end
