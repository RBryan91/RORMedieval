class CharactersController < ApplicationController
    before_action :require_login_player

    def show
      @character = Character.find(params[:id])
      @inventories = @character.inventorys.includes(:item)
    end
  
    def new
      @character = Character.new
    end
  
    def create
      @character = Character.new(character_params)
      @character.player_id = session[:player_id]
      @character.level = 1
      @character.po = 0
      @character.xp = 0

      if @character.save
        session[:character_id] = @character.id
        redirect_to @character
      else
        render :new, status: :unprocessable_entity
      end
   end
        
   private
     def character_params 
       params.require(:character).permit(:name, :force, :pv, :player_id, :po, :level, :xp)
     end
  end