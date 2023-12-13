class StepsController < ApplicationController
    before_action :require_login, except: [:startQuest]

    def new
        @step = Step.new
      end

    def show
        @step = Step.find(params[:id])
      end

    def edit
        @step = Step.find(params[:id])
      end  

    def update
      @step = Step.find(params[:id])
  
        if @step.update(step_params)
          redirect_to @step
        else
          render :edit, status: :unprocessable_entity
        end
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
    
    def startQuest
      @quest = Quest.find(params[:quest_id])
      @steps = Step.where(quest_id: @quest.id)
      
      @step_ids = @steps.map(&:id).sort

      @character = current_character

      @character.update(quest_id: @quest.id)
      @quest.update(character_id:@character.id)
      
      if params[:step_id].nil?
        @current_step = @steps.find_by(id: @step_ids.first)
        @current_step.update(character_id:@character.id)
        redirect(@current_step,@quest.title)
      elsif params[:step_id] == @step_ids.last
        @finish = true
        @current_step = @steps.find_by(id: @step_ids.last)
        update_previous_steps_to_nil(@current_step)
        @current_step.update(character_id:@character.id)
        redirect(@current_step,@quest.title,@finish)
      else
        @current_step = @steps.find_by(id: params[:step_id])
        update_previous_steps_to_nil(@current_step)
        @current_step.update(character_id:@character.id)
        redirect(@current_step,@quest.title)
      end

    end

    private
      def step_params 
          params.require(:step).permit(:titre, :xp, :monster_id, :enigme_id, :quest_id)          
      end

      def redirect(current_step,title,finish = false)
        if current_step.enigme_id
          enigme = Enigme.find(current_step.enigme_id)
          redirect_to enigme_path(enigme,finish: finish,quest:title,step:current_step.titre)
        end
        if current_step.monster_id
          monster = Monster.includes(:item).find(current_step.monster_id)
          redirect_to monster_path(monster,finish:finish,quest:title,step:current_step.titre)
        end
      end

      def update_previous_steps_to_nil(current_step)
        previous_step_ids = @step_ids.select { |step_id| step_id < current_step.id }
        previous_steps = Step.where(id: previous_step_ids)
        previous_steps.update_all(character_id: nil)
      end
end