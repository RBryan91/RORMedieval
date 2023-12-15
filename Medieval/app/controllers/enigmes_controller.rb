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
      @quest = Quest.find(session[:current_quest])
      @step = Step.find(session[:current_step])
      @character = current_character
      @enigme_message = []
     
      if params[:reponse] == @answers[@answers.true]
        @enigme_message << "VICTORY !"
        @enigme_message << "You answered with BRIO !"
        @enigme_message << "You earn #{@step.xp} xp after this enigme !"
        @enigme_message << "You finish the step #{@step.titre} !"

        if level_up(@step.xp)
          @enigme_message << "You passed level #{@character.level} !!! Go back to your character menu to split your characteristics points."
        end
        @win = true
      else
        @enigme_message << "GAME OVER !"
        @win = false
       end
       session[:enigme_message ] = @enigme_message
       redirect_to enigme_path(@enigme,win:@win,quest_id:@quest.id,step_id:@step.id)
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
