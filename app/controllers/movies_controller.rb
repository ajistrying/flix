class MoviesController < ApplicationController

  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :load_movie, only: [:show, :edit, :update, :destroy]

  def index
    case params[:filter]
    when "upcoming"
      @movies = Movie.upcoming
    when "recent"
      @movies = Movie.recent
    when "hits"
      @movies = Movie.hits
    when "flops"
      @movies = Movie.flops
    else
      @movies = Movie.released
    end
  end

  def show
    @fans = @movie.fans
    @genres = @movie.genres
    if current_user
      @favorite = current_user.favorites.find_by(movie_id: @movie.id) #Test to see if the user has already liked this movie
    end
  end

  def edit
  end

  def update
    # Update the movie with the permitted parameters
    if @movie.update(permitted_movie_params)
      # Redirect to the movie detail page with a flash message
      redirect_to movie_path(@movie), notice: "Movie successfully updated!"
    else
      render :edit
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(permitted_movie_params)
    if @movie.save
      redirect_to movie_path(@movie), notice: "Movie successfully created!"
    else
      render :new
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_url, alert: "Movie successfully deleted!"
  end

  private

  def load_movie
    @movie = Movie.find_by(slug: params[:id])
  end

  def permitted_movie_params
    params.require(:movie)
      .permit(
        :title, 
        :description, 
        :rating, 
        :released_on, 
        :total_gross,
        :director,
        :duration,
        :image_file_name,
        genre_ids: []
      )
  end

end
