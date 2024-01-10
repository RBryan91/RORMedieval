class AnswersController < ApplicationController
      before_action :require_login
      
      def new
        @answer = Answer.new
        @enigme_id = params[:enigme_id]
      end
  
      def create
          @answer = Answer.new(answer_params)
          
        if @answer.save          
          if session[:quest_id]
            redirect_to new_step_path(quest_id:session[:quest_id])
          else
          redirect_to master_path(current_master)  
          end

          else
            redirect_to new_answer_path(enigme_id:@answer.enigme_id)
          end
      end
        
      private
        def answer_params 
          params.require(:answer).permit(:reponse_1, :reponse_2, :reponse_3, :true, :enigme_id)
        end
end
