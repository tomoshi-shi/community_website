class LinkCategory < ApplicationRecord
  has_many :links
  
  # LinkCategory モデルを引数とし、それに属する Link モデルを返却
  def self.get_links(link_category)
    links = link_category.links
                         .order(:disp_order, :created_at)
    return links
  end
  
  def value
    send(:"#{value_type}_value")
  end
  
  def value=(x)
    send(:"#{value_type}_value=", x)
  end
end
