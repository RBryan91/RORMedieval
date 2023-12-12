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
      @monsters = Monster.includes(:item).where(id: @steps.pluck(:monster_id))
      @enigmes = Enigme.where(id: @steps.pluck(:enigme_id))
      @answers = Answer.where(enigme_id: @enigmes.pluck(:id))
      
      @step_ids = @steps.map(&:id).sort
      
      if params[:step_id].nil?
        @current_step = @steps.find_by(id: @step_ids.first)
        puts "laaaaa #{@current_step.titre}"
      elsif params[:step_id] == @step_ids.last
        @result = "finish"
      else
        @current_step = @steps.find_by(id: params[:step_id])
      end
    end

    private
      def step_params 
          params.require(:step).permit(:titre, :xp, :monster_id, :enigme_id, :quest_id)          
      end
end