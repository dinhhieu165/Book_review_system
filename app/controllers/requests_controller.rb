class RequestsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource params_method: :request_params

  def index
    @search = Request.of_user(params[:user_id]).ransack(params[:q])
    @requests = @search.result.joins(:book)
      .page(params[:page]).per(Settings.per_page)
  end

  def new
  end

  def create
    if @request.save
      respond_to do |format|
        format.json do
          render json: {
            is_success: true
          }
        end
      end
    else
      respond_to do |format|
        format.json do
          render json: {
            is_success: false
          }
        end
      end
    end
  end

  def destroy
    @request = Request.find_by id: params[:id]
    if @request.destroy
      flash[:success] = I18n.t "requests.index.destroy_success"
    else
      flash[:danger] = I18n.t "requests.index.destroy_failed"
    end
    redirect_to user_requests_path(params[:user_id])
  end

  private
  def request_params
    params.require(:request).permit(:user_id, :book_id)
  end
end
