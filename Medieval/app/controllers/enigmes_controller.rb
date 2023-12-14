class EnigmesController < ApplicationController
    before_action :require_login, except: [:show, :responses]

    def new
        @enigme = Enigme.new
    end

    def show
        @enigme = Enigme.find(params[:id])
        @answers = Answer.find_by(enigme_id:@enigme.id)
      end

    def responses
      @enigme_params = params.require(:enigme).permit(:id, :reponse)
      @enigme_id = @enigme_params[:id]
      @enigme = Enigme.find(@enigme_id)
      @answers = Answer.find_by(enigme_id:@enigme.id)
     
     
      if params[:reponse] == @answers[@answers.true]
        @win = true
      else
        @win = false
       end
       redirect_to enigme_path(@enigme,win:@win)
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
