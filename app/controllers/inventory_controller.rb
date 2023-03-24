class InventoryController < ApplicationController

  def index
    @inventory_items = Inventory.all
  end

  def update
    @inventory_item = Inventory.find(params[:id])
    quantity = params[:inventory][:quantity].to_i
    difference = quantity - @inventory_item.quantity
    
    if @inventory_item.update(inventory_params)
      InventoryModification.create(
        inventory_id: @inventory_item.id,
        quantity_added: difference > 0 ? difference : 0,
        quantity_removed: difference < 0 ? -difference : 0,
        date: Time.current
      )
      flash[:success] = 'Inventory updated successfully.'
      redirect_to root_path
    else
      flash.now[:error] = 'Failed to update inventory.'
      render :index
    end
  end
  
  def search_modifications
    @modifications = InventoryModification.where(date: params[:date])
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name, :quantity)
  end
end
