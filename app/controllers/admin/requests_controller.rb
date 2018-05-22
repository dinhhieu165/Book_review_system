class Admin::RequestsController < ApplicationController
  def index
    @search = Request.ransack params[:q]
    @search.sorts = Settings.default_sort if @search.sorts.empty?
    @requests = @search.result
      .joins(:user, :book).page(params[:page]).per(Settings.per_page)
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
  end

  def update
    @request = Request.find_by id: params[:id]
    if @request.update_attribute(:status, params[:status].to_i)
      if params[:status].to_i == Settings.requests.status_post[:approve]
         AdminMailer.approve_request(@request).deliver_now
      end
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
end

