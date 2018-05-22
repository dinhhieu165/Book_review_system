class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?
  before_action :load_category, only: %i(update, edit, destroy)

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to admin_categories_path
      flash[:success] = t("admin.flash.successful", obj: "Category", action: "create")
    else
      flash[:error] = t("admin.flash.failed", obj: "Category", action: "create")
      render :new
    end
  end

  def index
    @search = Category.ransack params[:q]
    @search.sorts = Settings.default_sort if @search.sorts.empty?
    @categories = @search.result
      .page(params[:page]).per Settings.per_page
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t("admin.flash.successful", obj: "Category", action: "update")
    else
      flash[:error] = t("admin.flash.failed", obj: "Category", action: "update")
      render :edit
    end
    redirect_to admin_categories_path
  end

  def destroy
    if @category.destroy
      flash[:success] = t("admin.flash.successful", obj: "Category", action: "destroy")
    else
      flash[:error] = t("admin.flash.failed", obj: "Category", action: "destroy")
    end
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit :name
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:error] = t("admin.flash.successful", obj: "Category", id: params[:id])
    redirect_to admin_categories_path
  end
end
