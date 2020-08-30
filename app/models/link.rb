class Link < ApplicationRecord
  belongs_to :link_category

  def value
    send(:"#{value_type}_value")
  end
  
  def value=(x)
    send(:"#{value_type}_value=", x)
  end
end
