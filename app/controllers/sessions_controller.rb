class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email]
    password = params[:session][:password]

    user = User.find_by(email: email)
    
    if user && user.authenticate(password)
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        flash[:success] = "Udało się zalogować!"
        redirect_back_or root_url
    else
      flash.now[:danger] = "Nieprawiłowy login/hasło"
      render 'new'
    end
  end

  def destroy
    if logged_in?
      log_out
      flash[:success] = "Udało się wylogować"
    end
    redirect_to root_path
  end
end
