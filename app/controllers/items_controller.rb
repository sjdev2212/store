class ItemsController < ApplicationController
  def index
    @items = Item.all
  end
  def show 
    @items = Item.where(category: params[:category])
  end
  def filter
    @category = params[:category]
    @items = Item.where(category: @category)
    render :filter 
  end
end
