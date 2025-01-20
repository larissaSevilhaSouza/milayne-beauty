class PhotoIten < ApplicationRecord
  belongs_to :item_story
  mount_uploader :photo, ImageItemStoreUploader
end
