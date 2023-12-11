class HdvsController < ApplicationController
    before_action :require_login_player

    def index
        @hdv = Hdv.all
    end

    def new
        @hdv = Hdv.new
    end

    def buy_item
        hdv = Hdv.find(params[:hdv_id])
        buyer = Character.find(session[:character_id])
        seller = Character.find(hdv.character_id)

        if buyer.po < hdv.price
            flash[:alert] = "Not enough currency to purchase this item."
          else
            buyer.po -= hdv.price
            seller.po += hdv.price
        
            inventory = Inventory.new(item_id: hdv.item_id, active: false, character_id: buyer.id)
            
            if inventory.save
                buyer.save
                seller.save
              hdv.destroy
              redirect_to hdvs_path, notice: 'Item purchased successfully.'
            else
              flash[:alert] = 'Failed to add item to inventory.'
            end
          end
    end

    def delete_item
        hdv = Hdv.find(params[:hdv_id])
        if hdv.character_id != session[:character_id]
            flash[:alert] = "Error."
        else
            inventory = Inventory.new(item_id:hdv.item_id,active:false,character_id:session[:character_id])
            if inventory.save
              hdv.destroy
              redirect_to hdvs_path, notice: 'Item deleted successfully.'
            else
              flash[:alert] = 'Failed to add item to inventory.'
            end
        end
    end

    def create
        @hdv = Hdv.new(hdv_params)

      if @hdv.save
        inventory_to_delete = Inventory.find_by(character_id: @hdv.character_id, item_id: @hdv.item_id, active: false)
        inventory_to_delete.destroy if inventory_to_delete.present?
        redirect_to hdvs_path
        else
          render :new, status: :unprocessable_entity
        end
      end

    private
      def hdv_params 
        params.require(:hdv).permit(:item_id, :price, :character_id )
      end
end
