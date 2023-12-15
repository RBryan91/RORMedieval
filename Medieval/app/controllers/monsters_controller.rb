class MonstersController < ApplicationController
      before_action :require_login, except: [:show,:fight]
      
      def new
        @monster = Monster.new
        @monster.pv = 0
        @monster.force = 0
      end

      def show
        @monster = Monster.includes(:item).find(params[:id])
        if session[:current_quest]
          @quest = Quest.includes(:item).find(session[:current_quest])
        end
        
      end

      def fight
        @monster = Monster.includes(:item).find(params[:monster_id])
        @character = current_character
        @character_original_pv = @character.pv
        @monster_original_pv = @monster.pv
        @combat_messages = []
        @quest = Quest.includes(:item).find(session[:current_quest])
        @step = Step.find(session[:current_step])

        @Allsteps = Step.where(quest_id: @quest.id)
        @step_ids = @Allsteps.map(&:id).sort

            # Assuming force and pv are numeric fields in your models
        while @monster.pv > 0 && @character.pv > 0
          # Character hits the monster
          pv_monster = @monster.pv - @character.force
          @monster.pv -= @character.force
          @combat_messages << "You hit the #{@monster.name} ! It has #{pv_monster} PV."

          # Check if the monster's pv is negative after the hit
          if @monster.pv <= 0
            # Monster is defeated
            @combat_messages << "You defeated the #{@monster.name} !"
            @combat_messages << "VICTORY !"
            @combat_messages << "You earn #{@step.xp} xp and #{@step.po} po after this battle !"
            @character.update(po:@character.po + @step.po)
            @bonus_percentage = (100 + @character.bonus_xp) / 100.0
            @final_xp = (@step.xp * @bonus_percentage).to_i
            if level_up(@final_xp)
              @combat_messages << "You passed level #{@character.level} !!! Go back to your character menu to split your characteristics points."
            end
            if @monster.item
              random_percentage = rand(1..100)
              if random_percentage <= @monster.rate
                @combat_messages << "AWESOME ! You find a #{@monster.item.name} on the corpse of this #{@monster.name} !"
                inventory = Inventory.new(item_id:@monster.item.id,active:false,character_id:@character.id)
                inventory.save
                @drop = true
                
              end
            end
            if @step.id == @step_ids.last
              @combat_messages << "You dit it ! You finished the quest #{@quest.title} !!! Well played Hero ! "
              @combat_messages << "You received #{@quest.item.name}, #{@quest.po} po and #{@quest.xp} as a reward !!!"
              @ended = true
            else
              @combat_messages << "You finished with success the step #{@step.titre}. Continue your quest #{@quest.title} !"
            end
            session[:combat_messages] = @combat_messages
            @character.update(pv:@character_original_pv)
            @monster.update(pv:@monster_original_pv)
            redirect_to monster_path(@monster,quest_id:@quest.id,step_id:@step.id,ended:@ended,drop:@drop)
            return
          end

          # Monster hits the character
          character_pv = @character.pv - @monster.force
          @character.pv -= @monster.force
          @combat_messages << "The #{@monster.name} hits you! You have #{character_pv} PV."
          # Check if the character's pv is negative after the monster's hit
          if @character.pv <= 0
            # Character is defeated
            @combat_messages << "You were defeated by the #{@monster.name} !"
            @combat_messages << "Your quest #{@quest.title} ends here at #{@step.titre}..."
            @combat_messages << "Come back stronger hero !"
            @combat_messages << "GAME OVER !"
            session[:combat_messages] = @combat_messages
            @character.update(pv:@character_original_pv)
            @monster.update(pv:@monster_original_pv)
            redirect_to monster_path(@monster,quest_id:@quest.id,step_id:@step.id,defeat: true)
            return
          end
        end
        # If the loop exits without redirection, something unexpected happened
        @combat_messages << 'An unexpected error occurred during the fight.'
        session[:combat_messages] = @combat_messages
        redirect_to monster_path(@monster,quest_id:@quest.id,step_id:@step.id)
      end
  
      def create
          @monster = Monster.new(monster_params)
          @monster.avatar = "avatar/bouftou.svg"
          
        if @monster.save
          if session[:quest_id]
            redirect_to new_step_path(quest_id:session[:quest_id])
          else
          redirect_to master_path(current_master)  
          end
        else
          render :new, status: :unprocessable_entity
        end
      end
        
      private
        def monster_params 
          params.require(:monster).permit(:name, :force, :pv, :item_id, :rate, :message)
        end

end
