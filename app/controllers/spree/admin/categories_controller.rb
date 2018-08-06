class Spree::Admin::CategoriesController < ApplicationController
  before_action :find_resource, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Spree::Category.all
  end

  def new
    @category   = Spree::Category.new
    @categories = Spree::Category.all.collect { |cat| [cat.name, cat.id] }
  end

  def create
    create_or_update_category(category_params)
  end

  def show
  end

  def edit
    categories_without_children = Spree::Category.where.not(parent_id: @category.id)

    @categories = categories_without_children.collect { |cat| [cat.name, cat.id] }
  end

  def update
    create_or_update_category(category_params)
  end

  def destroy
    if @category.destroy
      flash[:success] = 'Category deleted successfully!'
      redirect_to admin_categories_path
    else
      flash[:error] = 'Category not deleted'
    end
  end

  private

  def category_params
    params.require(:category).permit(:id, :name, :parent_id, :soft_position)
  end

  def find_resource
    @category = Spree::Category.find(params[:id])
  end

  def create_or_update_category(params)
    service = Spree::Admin::Categories::Saving.new(params)

    if service.save
      redirect_to admin_categories_path
    else
      flash[:error] = 'Category not saved'
    end
  end
end
