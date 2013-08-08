class RatingsRepository

  def self.ratings_for(product_id)
    ratings = JSON.parse(Faraday.get("http://localhost:9292/products/#{product_id}/ratings").body)["ratings"]
    ratings.collect do |r|
      ProxyRating.new(r["rating"])
    end
    #Rating.where(product_id: product_id)
  end

  def self.ratings_by(user_id)
    Rating.where(user_id: user_id)
  end

  def self.new_rating(attributes)
    ProxyRating.new(attributes)
  end

  def self.find_unique(attrs)
    source = Rating.find_unique(attrs)
    ProxyRating.new(source.attributes)
  end

  def self.create(attrs)
    Rating.create(attrs)
  end
end