class Video < ApplicationRecord
  include PgSearch

  validates :title, :url, :date_publish, presence: true
  validate :youtube_url

  pg_search_scope :search_title, against: :title, order_within_rank: "videos.updated_at DESC"

  extend FriendlyId
  friendly_id :title, use: :slugged

  def date_video
    date_publish.strftime("%d/%m/%Y")
  end

  def image
    YouTubeRails.extract_video_image(url, "medium")
  end

  def date
    date_publish.strftime("%d/%m/%Y")
  end

  def code
    self.url.match(/^(?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?([\w-]{10,})/)[1]
  end

  private

  def youtube_url
    unless url.match?(/^(?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?([\w-]{10,})/)
      errors.add(:url, "deve ser uma URL válida do YouTube")
    end
  end
end