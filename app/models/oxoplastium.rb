class Oxoplastium < ApplicationRecord
  mount_uploader :photo, PhotoOxUploader

  has_many :gallery_oxes, dependent: :destroy
  accepts_nested_attributes_for :gallery_oxes, allow_destroy: true
end
