class CharactersController < ApplicationController
    before_action :require_login_player

    def show
      @character = Character.find(params[:id])
      session[:character_id] = @character.id
      session.delete(:combat_messages)
      session.delete(:current_quest)
      session.delete(:current_step)
      @inventories = @character.inventorys.includes(:item)
      min_level = @character.level - 2
      max_level = @character.level + 2
      @valid_quetes = Quest
      .joins(:steps)
      .where(level: min_level..max_level)
      .distinct
      @in_progress = Quest
      .joins(:steps)
      .where(character_id: @character.id)
      .distinct
      @in_progress_quest_ids = @in_progress.pluck(:id)
      @in_progress_steps = Step.where(quest_id: @in_progress_quest_ids)
      @in_progressStep = @in_progress_steps.where(character_id: @character.id)
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

  def edit
    @character = Character.find(params[:id])
  end  

  def update
    @character = Character.find(params[:id])
    if (character_params_edit[:force].to_i + character_params_edit[:pv].to_i) - (@character.force + @character.pv) != 10
      render :edit, status: :unprocessable_entity
    end
      if @character.update(character_params_edit)
        session.delete(:level)
        redirect_to @character
      else
        render :edit, status: :unprocessable_entity
      end
  end
        
   private
     def character_params 
       params.require(:character).permit(:name, :force, :pv, :player_id, :po, :level, :xp)
     end
     def character_params_edit
      params.require(:character).permit(:force, :pv, :xp, :level, :po)
    end
  end