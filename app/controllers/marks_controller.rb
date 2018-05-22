class MarksController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :load_book, only: [:create, :show, :update]

  def new
  end

  def create
    @mark = current_user.marks.build mark_params
    if @mark.save
      respond_to do |format|
        format.js
      end
    end
  end

  def show
    @marks = @book.marks
  end

  def update
    mark = @book.marks.find_by(user_id: mark_params[:user_id],
                               book_id: mark_params[:book_id])
    mark ||= @book.marks.new user_id: mark_params[:user_id]

    if mark.update_attributes mark_params
      respond_to do |format|
        format.js
      end
    end
  end

  private
  def mark_params
    params.require(:mark).permit :user_id, :book_id, :read_status,
                                      :favorite
  end

  def load_book
    @book = Book.find_by id: params[:id]
    if @book.nil?
      flash[:danger] = t "books.book_infomation.not_found"
      redirect_to root_url
    end
  end
end
