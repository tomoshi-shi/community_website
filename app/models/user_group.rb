class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group

  def value
    send(:"#{value_type}_value")
  end

  def value=(x)
    send(:"#{value_type}_value=", x)
  end
end
