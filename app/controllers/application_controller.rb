class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def valid_session
        @user = user_signed_in? ? current_user : nil
        redirect_to root_path unless @user

        @user
    end
end
