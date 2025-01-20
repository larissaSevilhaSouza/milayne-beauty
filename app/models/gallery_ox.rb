class GalleryOx < ApplicationRecord
  belongs_to :oxoplastium
  mount_uploader :photo, PhotoOxUploader  

end
