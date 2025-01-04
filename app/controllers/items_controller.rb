class ItemsController < ApplicationController
  def index
    @items = Item.all
  end
  def show 
    @item = Item.find(params[:id])
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
    def edit
      @item = Item.find(params[:id])

    end
    def update
      @item = Item.find(params[:id])
      if @item.update(item_params)
        redirect_to items_path
      else
        render :edit
      end
    end
    def destroy
      @item = Item.find(params[:id])
      @item.destroy
      redirect_to items_path  notice: "Item deleted"
    end

  
    
  

  private

  def item_params
    params.require(:item).permit(:name, :price, :category, :description,:stock, :image)
  end
end
