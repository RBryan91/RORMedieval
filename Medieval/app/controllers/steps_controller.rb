class StepsController < ApplicationController
    def new
        @step = Step.new
        @quest_id = params[:quest_id]
      end

    def create
        @step = step.new(step_params)
      if @step.save
          redirect_to new_step_path(quest_id: @quest.id)
        else
          render :new, status: :unprocessable_entity
        end
      end

    private
      def step_params 
        unless params[:step][:monster_id].present? ^ params[:step][:enigme_id].present?
            # Both or none of them are present, handle the error or redirect
          end
          
          # Continue with permitting the parameters
          params.require(:step).permit(:titre, :quest_id, :xp, :monster_id, :enigme_id)          
      end
end
