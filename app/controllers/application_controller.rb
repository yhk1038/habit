class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    # Must sign-in session space
    def valid_session
        @user = user_signed_in? ? current_user : nil
        redirect_to root_path unless @user

        @user
    end

    # Must private session space
    def gatekeeper
        redirect_to root_path if @user || current_user != @user
    end
end
