class Article < ApplicationRecord
	belongs_to :article_series

	enum publish_status: {unpublished: 1, published: 2, closed: 3}

	def value
			send(:"#{value_type}_value")
	end

	def value=(x)
			send(:"#{value_type}_value=", x)
	end
end
