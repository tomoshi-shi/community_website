class Group < ApplicationRecord
  has_many :user_groups
  has_many :users, through: :user_groups
  has_many :information_categories
  has_many :projects
  
  def value
    send(:"#{value_type}_value")
  end
  
  def value=(x)
    send(:"#{value_type}_value=", x)
  end
end
