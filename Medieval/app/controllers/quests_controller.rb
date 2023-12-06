class QuestsController < ApplicationController
    def new
        @quest = Quest.new
        @quest.xp = 0
    end

    def create
        @quest = Quest.new(quest_params)
        if @quest.save
          redirect_to new_step_path(quest_id:@quest.id)
        else
          render :new, status: :unprocessable_entity
        end
    end

    private
        def quest_params 
          params.require(:quest).permit(:title, :xp, :item_id, :master_id)
        end

end
