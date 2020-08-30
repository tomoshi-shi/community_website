class ProjectStatus < ApplicationRecord
  belongs_to :project
  belongs_to :user

  def value
    send(:"#{value_type}_value")
  end
  
  def value=(x)
    send(:"#{value_type}_value=", x)
  end
end
