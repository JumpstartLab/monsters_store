module HacksForActionView
  def id
    0
  end

  def persisted?
    !!created_at
  end
end

class ProxyRating
  def self.defined_attributes
    [:product_id, :user_id, :title, :body, :stars, :created_at]
  end
  
  attr_accessor *defined_attributes
  attr_accessor :rated_at

  extend ActiveModel::Naming
  include ActiveModel::Conversion

  def initialize(attributes)
    ProxyRating.defined_attributes.each do |attr|
      send "#{attr}=", (attributes[attr.to_s] || attributes[attr])
    end
    self.rated_at = self.created_at = Time.parse(attributes["created_at"])
  end

  def save
    RatingsRepository.create(self.attributes)
  end

  def attributes
    self.class.defined_attributes.each_with_object({}) do |attr, hash|
      hash[attr] = send(attr)
    end
  end

  def user
    User.find(user_id)
  end

  def editable?
    rated_at < 15.minutes.ago
  end

  include HacksForActionView
end
