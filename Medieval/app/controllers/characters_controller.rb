class CharactersController < ApplicationController
    before_action :require_login_player

    def show
      @character = Character.find(params[:id])
      session[:character_id] = @character.id
      @inventories = @character.inventorys.includes(:item)
      min_level = @character.level - 2
      max_level = @character.level + 2
      @valid_quetes = Quest.where(level: min_level..max_level)
      @in_progress = Quest.where(character_id: @character.id)

    end

    def delete_character
      character = Character.find(params[:character_id])
      character.destroy
      flash[:notice] = "Character successfully deleted."
      redirect_to player_path(session[:player_id])
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