class CommentsController < ApplicationController
  before_action :load_comment, only: %i[destroy update]
  before_action :authenticate_user!

  def new
  end

  def create
    @comment = @review.comments.build comment_params
    @comment.user_id = current_user.id
    if @comment.save
      @comments = @review.comments.desc_create_at.page(params[:page]).per Settings.per_page
      render json: {
        status: :success,
        content: render_to_string(partial: "comment/comment", locals: {comments: @comments})
      }
    else
      render json: {
        status: :error
      }
    end
  end

  def destroy
    @comment = Comment.find_by id: params[:id]
    if @comment.destroy
      @comments = @review.comments.desc_create_at.page(params[:page]).per Settings.per_page
      render json: {
        status: :success,
        content: render_to_string(partial: "comment/comment", locals: {comments: @comments})
      }
    else
      render json: {
        status: :error
      }
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :review_id, :user_id
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment
    flash[:error] = t("admin.flash.successful", obj: "comment", id: params[:id])
    redirect_to review_path(@reivew)
  end

  def load_reviews
    @review = Review.find_by id: params[:reivew_id]
    return if @review
    flash[:error] = t("admin.flash.successful", obj: "review", id: params[:review_id])
    redirect_to root_path
  end
end
