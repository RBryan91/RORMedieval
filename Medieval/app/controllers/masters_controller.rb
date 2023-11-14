class MastersController < ApplicationController

    def show
      @master = Master.find(params[:id])
    end

    def new
      @master = Master.new
    end

    def create
        @master = Master.new(master_params)
        
      if @master.save
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
