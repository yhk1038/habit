class SiteController < ApplicationController
    def randing
        redirect_to projects_path if user_signed_in?
    end
end
