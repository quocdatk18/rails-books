class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_category, only: %i[show edit update destroy]

  def index
    @q = Category.ransack(params[:q])
    @pagy, @categories = pagy(@q.result.order(updated_at: :desc))
  end

  def show; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = t('success')
      redirect_to admin_categories_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:success] = t('success')
      redirect_to admin_categories_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t('success')
    else
      flash[:errors] = t('errors')
    end
    redirect_to admin_categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
