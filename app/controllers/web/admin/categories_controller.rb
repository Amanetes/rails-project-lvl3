# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  before_action :set_category, only: %i[edit update destroy]

  def index
    @categories = Category.all.page(params[:page])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = 'Категория создана'
      redirect_to admin_categories_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:success] = 'Категория обновлена'
      redirect_to admin_categories_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = 'Категория удалена'
      redirect_to admin_categories_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
