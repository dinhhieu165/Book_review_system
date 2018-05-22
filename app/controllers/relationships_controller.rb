class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user, only: :index

  def index
    @users = @user.send("#{params[:message]}")
      .page(params[:page]).per(Settings.per_page)
  end

  def create
    @user = User.find_by id: params[:followed_id]
    if @user.nil?
      flash[:danger] = t "follow.not_user"
      redirect_to current_user
    else
      current_user.follow @user
      respond_to do |format|
        format.json do
          render json: {
            success: true,
            followed: @user.followers.count
          }
        end
      end
    end
  end

  def destroy
    @user = Relationship.find_by(followed_id: params[:id]).followed
    if @user.nil?
      flash[:danger] = t "follow.not_user"
      redirect_to current_user
    else
      current_user.unfollow @user
      respond_to do |format|
        format.json do
          render json: {
            success: true,
            followed: @user.followers.count
          }
        end
      end
    end
  end

  private
  def load_user
    @user = User.find_by id: params[:user_id]
    if @user.nil?
      flash[:danger] = t "exists_user"
      redirect_to root_url
    end
  end
end
