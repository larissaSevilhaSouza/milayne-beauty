class SubMenu < ApplicationRecord
  belongs_to :menu
  audited
end
