class Spree::Admin::ItemsController < ApplicationController
  before_action :find_resource, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:new, :edit]

  def index
    @items = Spree::Item.all
  end

  def new
    @item = Spree::Item.new
  end

  def create
    create_or_update_item(item_params)
  end

  def show
  end

  def edit
  end

  def update
    create_or_update_item(item_params)
  end

  def destroy
    if @item.destroy
      flash[:success] = 'Item deleted successfully!'
      redirect_to admin_items_path
    else
      flash[:error] = 'Item not deleted'
    end
  end

  private

  def item_params
    params.require(:item).permit(:id, :name, :category_id, :image)
  end

  def find_resource
    @item = Spree::Item.find(params[:id])
  end

  def set_categories
    @categories = Spree::Category.all.collect { |cat| [cat.name, cat.id] }
  end

  def create_or_update_item(params)
    service = Spree::Admin::Items::Saving.new(params)

    if service.save
      redirect_to admin_items_path
    else
      flash[:error] = 'Item not saved'
    end
  end
end
