class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[edit update]
  before_action :correct_user, only: %i[edit]
  before_action :load_user, only: %i[edit update show]


  def index
    @users = User.page(params[:page]).per(Settings.per_page).has_name(params[:search])
  end

  def show
    @favorite_books = @user.marks.favorited
    @reading_history_books = @user.marks.reading_history
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:error] = "User with id: #{params[:id]} not exist"
  end
end
