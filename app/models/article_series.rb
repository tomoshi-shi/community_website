class ArticleSeries < ApplicationRecord
  has_many :articles

  enum publish_status: {closed: 1, published: 2}

  def value
      send(:"#{value_type}_value")
  end

  def value=(x)
      send(:"#{value_type}_value=", x)
  end
end
