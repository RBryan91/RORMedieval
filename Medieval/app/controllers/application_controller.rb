class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_player, :logged_in_player?
    helper_method :current_master, :logged_in?

    def index
    end
 
    private
 
    def current_player
      @current_player ||= Player.find(session[:player_id]) if session[:player_id]
    end
 
    def logged_in_player?
      !!current_player
    end
 
    def require_login_player
      unless logged_in_player?
        redirect_to connect_players_path, alert: 'You must be logged in to access this page.'
      end
    end
  
    def current_master
      @current_master ||= Master.find(session[:master_id]) if session[:master_id]
    end

    def current_character
      @current_character ||= Character.find(session[:character_id]) if session[:character_id]
    end
  
    def logged_in?
      !!current_master
    end

    def require_login
      unless logged_in?
        redirect_to login_masters_path, alert: 'You must be logged in to access this page.'
      end
    end
  end
