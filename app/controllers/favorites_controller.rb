class FavoritesController < ApplicationController

  before_action :require_signin
  before_action :load_movie

  def create
    @movie.fans << current_user
    redirect_to @movie
  end

  def destroy
    favorite = current_user.favorites.find(params[:id])
    
    favorite.destroy

    redirect_to @movie
  end

  private

  def load_movie
    @movie = Movie.find_by(slug: params[:id])
  end

end
