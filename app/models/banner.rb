class Banner < ApplicationRecord
  belongs_to :format_ad, inverse_of: :banner
  mount_uploader :photo, PhotoBannerUploader 
  mount_uploader :video, VideoUploader
  validates  :title, presence: true 
  enum category: {
    "Foto": 0,
    "Video": 1
  }
  private

  def photo_size_validation
    errors[:photo] << 'deve ter menos de 2MB' if photo.size > 2.megabytes
  end
  audited
  
end
