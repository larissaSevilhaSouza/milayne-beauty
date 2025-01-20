class Store < ApplicationRecord
  mount_uploader :image, ImageStoryUploader
end
