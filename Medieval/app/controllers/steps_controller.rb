class StepsController < ApplicationController
    before_action :require_login

    def new
        @step = Step.new
      end

    def create
        @step = Step.new(step_params)
        session[:check] = 1

      if @step.save
          redirect_to new_step_path(quest_id: @step.quest_id)
        else
          render :new, status: :unprocessable_entity
        end
      end

    private
      def step_params 
          params.require(:step).permit(:titre, :xp, :monster_id, :enigme_id, :quest_id)          
      end
end
