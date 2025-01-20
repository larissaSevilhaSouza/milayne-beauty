class FormatAd < ApplicationRecord
  validates :title, :width, :height, presence: true

  has_many :banner, inverse_of: :format_ad
end
