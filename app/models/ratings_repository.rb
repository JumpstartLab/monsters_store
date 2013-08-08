class RatingsRepository
  def self.wrapper(name = ProxyRating)
    name
  end

  def self.get(path, adapter = Faraday)
    @connection ||= adapter
    @connection.get("http://localhost:9292/#{path}").body
  end

  def self.get_json(path)
    JSON.parse(get(path))
  end

  def self.get_ratings(path)
    get_json(path)["ratings"].map{|r| wrapper.new(r["rating"])}
  end

  def self.get_rating(path)
    wrapper.new( get_json(path)["rating"] )
  end

  def self.ratings_for(product_id)
    get_ratings "products/#{product_id}/ratings"
  end

  def self.ratings_by(user_id)
    get_ratings "users/#{user_id}/ratings"
  end

  def self.new_rating(attributes)
    wrapper.new(attributes)
  end

  def self.find_unique(attrs)
    get_rating "products/#{attrs['product_id']}/ratings/#{attrs['user_id']}"
  end

  def self.create(attrs)
    Rating.create(attrs)
  end
end