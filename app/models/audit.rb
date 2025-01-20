 class Audit < ApplicationRecord
  belongs_to :user, optional: true

  def self.log(user:, action:, model:, model_id:, changes: {})
    create!(
      user: user,
      action: action,
      auditable_type: model,
      auditable_id: model_id,
      audited_changes: changes
    )
  end
end
