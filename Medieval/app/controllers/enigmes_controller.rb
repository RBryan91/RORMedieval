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
      @quest = Quest.includes(:item).find(session[:current_quest])
      @step = Step.find(session[:current_step])
      @character = current_character
      @enigme_message = []
      @Allsteps = Step.where(quest_id: @quest.id)
      @step_ids = @Allsteps.map(&:id).sort
     
      if params[:reponse] == @answers[@answers.true]
        @enigme_message << "VICTORY !"
        @enigme_message << "You answered with BRIO !"
        @enigme_message << "You earn #{@step.xp} xp and #{@step.po} po after this enigme !"
        @enigme_message << "You finish the step #{@step.titre} !"
        @character.update(po:@character.po + @step.po)
        @bonus_percentage = (100 + @character.bonus_xp) / 100.0
        @final_xp = (@step.xp * @bonus_percentage).to_i
        if level_up(@final_xp)
          @enigme_message << "You passed level #{@character.level} !!! Go back to your character menu to split your characteristics points."
        end
        if @step.id == @step_ids.last
          @enigme_message << "You dit it ! You finished the quest #{@quest.title} !!! Well played Hero ! "
          @enigme_message << "You received #{@quest.item.name}, #{@quest.po} po and #{@quest.xp} as a reward !!!"
          @ended = true
        else
          @enigme_message << "You finished with success the step #{@step.titre}. Continue your quest #{@quest.title} !"
        end
        @win = true
      else
        @enigme_message << "You answered wrongly !"
        @enigme_message << "Your quest #{@quest.title} ends here at #{@step.titre}..."
        @enigme_message << "Come back smarter hero !"
        @enigme_message << "GAME OVER !"
        @win = false
       end
       session[:enigme_message ] = @enigme_message
       redirect_to enigme_path(@enigme,win:@win,quest_id:@quest.id,step_id:@step.id,ended:@ended)
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
