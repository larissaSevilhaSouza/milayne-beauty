class Permission < ApplicationRecord
  belongs_to :user
  audited
end
