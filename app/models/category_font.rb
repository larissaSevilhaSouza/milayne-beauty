class CategoryFont < ApplicationRecord
  audited
  validates :title, presence: :true
end
