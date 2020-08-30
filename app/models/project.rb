class Project < ApplicationRecord
  # 自己結合のリレーション
  belongs_to :parent, foreign_key: :parent_id
  has_many :children, class_name: 'Project', foreign_key: :parent_id

  # 自己結合以外のリレーション
  belongs_to :group
  has_many :project_statuses

  def value
    send(:"#{value_type}_value")
  end

  def value=(x)
    send(:"#{value_type}_value=", x)
  end
end
