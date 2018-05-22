class Admin::BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?
  before_action :load_book, only: %i(update edit destroy show)

  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t("admin.flash.successful", obj: "book", action: "create")
      redirect_to admin_books_path
    else
      flash[:error] = t("admin.flash.failed", obj: "book", action: "create")
      render :new
    end
  end

  def index
    @search = Book.ransack params[:q]
    @search.sorts = Settings.default_sort if @search.sorts.empty?
    @books = @search.result
      .joins(:category)
      .page(params[:page]).per Settings.per_page
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
  end

  def edit
  end

  def show
  end

  def update
    if @book.update_attributes book_params
      flash[:success] = t("admin.flash.successful", obj: "book", action: "update")
    else
      flash[:error] = t("admin.flash.failed", obj: "book", action: "update")
      render :edit
    end
    redirect_to admin_books_path
  end

  def destroy
    if @book.destroy
      flash[:success] = t("admin.flash.successful", obj: "book", action: "destroy")
    else
      flash[:error] = t("admin.flash.failed", obj: "book", action: "destroy")
    end
    redirect_to admin_books_path
  end

  private

  def book_params
    params.require(:book).permit :title, :author, :description, :publish_date, :price, :number_of_pages, :category_id, :image
  end

  def load_book
    @book = Book.find_by id: params[:id]
    @categories = Category.all
    return if @book
    flash[:error] = t("admin.flash.error", obj: "book", id: params[:id])
    redirect_to admin_books_path
  end
end
