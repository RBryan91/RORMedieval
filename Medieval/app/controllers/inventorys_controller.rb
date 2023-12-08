class InventorysController < ApplicationController
    before_action :require_login_player

    def show
      @inventory = Inventory.find(params[:id])
    end

    def update
        params[:inventory_ids].each do |inventory_id|
          inventory = Inventory.find(inventory_id)
          inventory.update(active: params["active_#{inventory_id}"] == "1")
        end
        redirect_to character_path, notice: "Inventory status updated successfully."
    end
  
    def new
      @inventory = Inventory.new
    end
  
    def create
      @inventory = Inventory.new(inventory_params)
      @inventory.character_id = session[:character_id]
      @inventory.save
   end
        
   private
     def inventory_params 
       params.require(:inventory).permit(:item_id, :active, :character_id)
     end
     def inventory_edit_params
        params.permit(:active)
     end
  end
