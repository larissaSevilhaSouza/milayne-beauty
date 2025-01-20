class About < ApplicationRecord
  mount_uploader :photo, PhotoAboutUploader
  validates :text, :sumary, presence: true
  audited
end
