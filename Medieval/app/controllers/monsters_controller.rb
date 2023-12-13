class MonstersController < ApplicationController
      before_action :require_login, except: [:show]
      
      def new
        @monster = Monster.new
        @monster.pv = 0
        @monster.force = 0
      end

      def show
        @monster = Monster.find(params[:id])
      end
  
      def create
          @monster = Monster.new(monster_params)
          
        if @monster.save
            redirect_to new_step_path(quest_id:session[:quest_id])
          else
            render :new, status: :unprocessable_entity
          end
      end
        
      private
        def monster_params 
          params.require(:monster).permit(:name, :force, :pv, :item_id, :rate, :message)
        end

end
