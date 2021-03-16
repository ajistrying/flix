class ReviewsController < ApplicationController

  before_action :require_signin
  # We always want to run the set_movie method before running any action's code
  before_action :load_movie
  
  
  def index
    @reviews = @movie.reviews
  end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(permitted_review_params)
    @review.user = current_user
    if @review.save
      redirect_to movie_reviews_path(@movie), notice: "Thanks for the review!"
    else
      render :new
    end
  end

  def destroy
    @review = @movie.reviews.find(params[:id])
    @review.destroy
    redirect_to movie_reviews_path(@movie), notice: "The review has been removed."
  end

  private

  def permitted_review_params
    params.require(:review).permit(:stars, :comment)
  end

  def load_movie
    @movie = Movie.find_by(slug: params[:id])
  end


end
