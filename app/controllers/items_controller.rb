class ItemsController < ApplicationController
  include ActionView::RecordIdentifier
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
      redirect_to items_path, notice: "Item created successfully."
    else
      render :new, status: :unprocessable_entity # Ensure the correct status code is returned
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
  
    # Append new images without replacing existing ones
    if params[:item][:images].present?
      params[:item][:images].each do |image|
        @item.images.attach(image)
      end
    end
  
    if @item.update(item_params.except(:images))
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(dom_id(@item), partial: "items/item", locals: { item: @item })
        end
        format.html { redirect_to items_path, notice: "Item updated successfully." }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(dom_id(@item), partial: "items/form", locals: { item: @item })
        end
        format.html { render :edit }
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
  
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(dom_id(@item))
      end
      format.html { redirect_to items_path, notice: "Item deleted successfully." }
    end
  end
  private

  def item_params
    params.require(:item).permit(:name, :price, :category, :description, :stock, images: [])
  end
end
