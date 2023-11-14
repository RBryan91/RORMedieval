class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_master, :logged_in?
  
    private
  
    def current_master
      @current_master ||= Master.find(session[:master_id]) if session[:master_id]
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
