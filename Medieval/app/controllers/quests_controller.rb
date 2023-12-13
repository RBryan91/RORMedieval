class QuestsController < ApplicationController
    before_action :require_login

    def new
        @quest = Quest.new
    end

    def create
        @quest = Quest.new(quest_params)
        if @quest.save
          session[:quest_id] = @quest.id
          redirect_to new_step_path(quest_id:@quest.id)
        else
          render :new, status: :unprocessable_entity
        end
    end

    def delete_quest
      @quest = Quest.find(params[:quest_id])
      @step = Step.where(quest_id:@quest.id)
      if @step.any?
        @step.destroy_all
      end
      @quest.destroy
      flash[:notice] = "Character successfully deleted."
      redirect_to master_path(current_master)
    end

    private
        def quest_params 
          params.require(:quest).permit(:title, :xp, :item_id, :master_id, :level)
        end
end
