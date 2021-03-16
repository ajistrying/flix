class SessionsController < ApplicationController
  def new
    
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to (session[:intended_url] || user_path(@user)), notice: "Welcome back, #{user.name}"
    else
      flash.now[:alert] = "Invalid email/password combination" #flash.now renders the message within the same request
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to movies_url, notice: "You're now signed out!"
  end
end
