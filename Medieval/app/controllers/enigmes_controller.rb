class EnigmesController < ApplicationController
    before_action :require_login

    def new
        @enigme = Enigme.new
      end
  
      def create
          @enigme = Enigme.new(enigme_params)
          
        if @enigme.save
            redirect_to new_answer_path(enigme_id: @enigme.id)
          else
            render :new, status: :unprocessable_entity
          end
      end
        
      private
        def enigme_params 
          params.require(:enigme).permit(:titre)
        end

end
