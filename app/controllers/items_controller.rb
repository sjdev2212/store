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
  def new 
    @item = Item.new
  end
  def create
    @item =Item.new(item_params)

    if @item.save
      redirect_to items_path 
    else
      render :new
    end
  
    
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :category, :description,:stock, :image)
  end
end
