class MastersController < ApplicationController

    def show
      @master = Master.find(params[:id])
      @quest = @master.quests
      @step = Step.where(quest_id: @quest.pluck(:id))
      session.delete(:check)
      
    end

    def new
      @master = Master.new
    end

    def create
        @master = Master.new(master_params)
        
      if @master.save
          session[:master_id] = @master.id
          redirect_to @master
        else
          render :new, status: :unprocessable_entity
        end
    end
      
    private
      def master_params 
        params.require(:master).permit(:username, :password)
      end
end
