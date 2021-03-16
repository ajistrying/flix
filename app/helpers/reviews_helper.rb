module ReviewsHelper

  def average_rating(movie)
    if movie.average_rating.zero?
      content_tag(:strong, "No Reviews")
    else
      pluralize(number_with_precision(movie.reviews.average(:stars), precision: 1), "star")
    end
  end

end
