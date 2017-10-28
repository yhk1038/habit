class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    # Must sign-in session space
    def login_first
        @user = user_signed_in? ? current_user : nil
        redirect_to new_user_session_path unless @user

        @user
    end

    # Must private session space
    def gatekeeper
        if session[:authenticated]
            session[:authenticated] = false
        else
            session[:authenticated] = true
            redirect_to root_path if @user || current_user != @user
        end
    end
end
