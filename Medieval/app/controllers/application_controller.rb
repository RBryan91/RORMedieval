class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_player, :logged_in_player?
 
    private
 
    def current_player
      @current_player ||= Player.find(session[:player_id]) if session[:player_id]
    end
 
    def logged_in_player?
      !!current_player
    end
 
    def require_login_player
      unless logged_in_player?
        redirect_to connexion_players_path, alert: 'You must be logged in to access this page.'
      end
    end
end
