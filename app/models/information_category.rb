class InformationCategory < ApplicationRecord
  belongs_to :group
  has_many :information

  def value
    send(:"#{value_type}_value")
  end

  def value=(x)
    send(:"#{value_type}_value=", x)
  end
end
