class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper

    def logged_in_users
        unless logged_in?
            store_location
            flash[:danger] = "Musisz się najpierw zalogować"
            redirect_to login_path
        end
    end
end
