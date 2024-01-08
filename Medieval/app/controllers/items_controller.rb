class ItemsController < ApplicationController
    before_action :require_login, except: [:show]

    def new
        @item = Item.new
        @item.xp = 0
        @item.pv = 0
        @item.force = 0
    end

    def show
      @item = Item.find(params[:id])
    end

    def create
        @item = Item.new(item_params)
        case @item.category
        when 'Arme'
          @item.image = "avatar/epee.png"
        when 'Bouclier'
          @item.image = "avatar/bouclier.png"
        when 'Casque'
          @item.image = "avatar/capuche.png"
        else
          puts 'Triche'
        end
        
      if @item.save
          redirect_to master_path(current_master) 
        else
          render :new, status: :unprocessable_entity
        end
      end

    private
      def item_params 
        params.require(:item).permit(:name, :category, :pv, :force, :xp, :source)
      end
end
