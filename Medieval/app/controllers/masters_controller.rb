class MastersController < ApplicationController
    before_action :require_login, except: [:login, :authenticate, :new, :create]

    def login
      render 'login'
    end

    def authenticate
      @master = Master.find_by(username: params[:username])
      
      if @master && @master.authenticate(params[:password])
        session[:master_id] = @master.id
        redirect_to @master
      else
        flash[:error] = 'Invalid username or password'
        render :login
      end
    end

    def logout
      reset_session
      redirect_to root_path
    end

    def show
      @master = Master.find(params[:id])
      @quest = @master.quests
      @step = Step.where(quest_id: @quest.pluck(:id))
      session.delete(:check)
      session.delete(:quest_id)
      @quest_in_progress = Quest.includes(:steps, :character).where(master_id: @master.id, character_id: !nil).where.not(steps: { character_id: nil })
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
