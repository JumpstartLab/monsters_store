class RatingsRepository

  def self.ratings_for(product_id)
    Rating.where(product_id: product_id)
  end

  def self.ratings_by(user_id)
    Rating.where(user_id: user_id)
  end

  def self.new_rating(attributes)
    Rating.new(attributes)
  end

  def self.find_unique(attributes)
    Rating.find_unique(attributes)
  end
end