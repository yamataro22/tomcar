class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper

    def logged_in_users
        unless logged_in?
            store_location
            flash[:danger] = "You need to login first"
            redirect_to login_path
        end
    end
end
