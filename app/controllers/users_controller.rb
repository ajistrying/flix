class UsersController < ApplicationController

  before_action :require_signin, except: [:new, :create] # Checks to see if the user is signed in 
  before_action :require_correct_user, only: [:edit, :update, :destroy] # Checks if the current user matches with the requested user info

  # The order in which you declare before_action methods is crucial. Before an action is run, 
  # the before_action methods are executed in turn starting at the top and working down. 
  # If at any point along the way one of the before_action methods causes a redirect (or returns false), 
  # then execution terminates. So by putting the require_correct_user check after the require_signin check, 
  # we're assured that the user is signed in before checking that they're the correct user.
  

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @favorite_movies = @user.favorite_movies
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(permitted_user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: "Thanks for signing up!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(permitted_user_params)
      redirect_to user_path(@user), notice: "Account successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to users_url, alert: "Account successfully deleted"
  end


  private

  def permitted_user_params
    params.require(:user).permit(:name, :email, :username, :password, :password_confirmation)
  end

  def require_correct_user
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to root_url
    end
  end

end
