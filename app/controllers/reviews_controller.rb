class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_review, only: [:show, :destroy, :update]

  def new
    @review = Review.new
  end

  def index
    @reviews = Review.page(params[:page]).per Settings.per_page
  end

  def create
    @review = Review.new review_params
    if @review.save
      flash[:success] = t "complete"
      redirect_to @review
    else
      flash[:warning] = t "not_complete"
      redirect_to root_url
    end
  end

  def show
    @comments = @review.comments.desc_create_at.page(params[:page]).per Settings.per_page
    @book = Book.find_by id: @review.book_id
    return if @book
      flash[:warning] = t "not_found"
      redirect_to books_path
  end

  def update
    if @review.update_attributes review_params
      flash[:success] = t "complete"
    else
      flash[:danger] = t "not_complete"
    end
    redirect_to @review
  end

  def destroy
    if @review.destroy
      flash[:success] = t "success_delete"
    else
      flash[:danger] = t "not_success_delete"
    end
    redirect_to books_path
  end

  private

  def review_params
    params.require(:review).permit :user_id, :book_id, :title,
      :content
  end

  def load_review
    @review = Review.find_by id: params[:id]
    return if @review
      flash[:warning] = t "not_found"
      redirect_to books_path
  end

end
