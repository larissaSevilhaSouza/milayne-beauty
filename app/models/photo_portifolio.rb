class PhotoPortifolio < ApplicationRecord
  mount_uploader :photo, FotoUploader
  validates :photo, presence: true
end
