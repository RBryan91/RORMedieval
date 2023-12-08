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
      if @item.save
          redirect_to new_quest_path
        else
          render :new, status: :unprocessable_entity
        end
      end

    private
      def item_params 
        params.require(:item).permit(:name, :category, :pv, :force, )
      end
end
