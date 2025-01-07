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
    @item = Item.new(item_params)

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
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to items_path, notice: "Item updated successfully." }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@item, partial: "items/form", locals: { item: @item }) }
        format.html { render :index }
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to items_path, notice: "Item deleted successfully." }
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :category, :description, :stock, :image)
  end
end
