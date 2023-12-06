class MonstersController < ApplicationController

      def new
        @monster = Monster.new
        @monster.pv = 0
        @monster.force = 0
      end
  
      def create
          @monster = Monster.new(monster_params)
          
        if @monster.save
            redirect_to new_step_path
          else
            render :new, status: :unprocessable_entity
          end
      end
        
      private
        def monster_params 
          params.require(:monster).permit(:name, :force, :pv, :item_id, :rate)
        end
end
