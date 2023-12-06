class AnswersController < ApplicationController

      def new
        @answer = Answer.new
      end
  
      def create
          @answer = Answer.new(answer_params)
          
        if @answer.save
          redirect_to new_step_path
          else
            render :new, status: :unprocessable_entity
          end
      end
        
      private
        def answer_params 
          params.require(:answer).permit(:reponse_1, :reponse_2, :reponse_3, :true, :enigme_id)
        end
end
