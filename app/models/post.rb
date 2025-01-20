class Post < ApplicationRecord
  before_create :set_default_date_publish

  include PgSearch::Model
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  def should_generate_new_friendly_id?
    title_changed?
  end

  pg_search_scope :search_by_slug_prefix, against: :slug, using: { tsearch: { prefix: true } }, order_within_rank: "posts.date_publish DESC"
  
  mount_uploader :cover, PostUploader

  has_many :post_images, dependent: :destroy
  has_many :post_views, dependent: :destroy
   
  has_and_belongs_to_many :album, inverse_of: :post

  belongs_to :post_category
  validates :title, :cover, presence: true

  # Publish date formatted
  def formatted_date_publish
    if self.date_publish.present?
      I18n.l(self.date_publish.to_date, format: :long)      
    end    
  end
  
  def set_default_date_publish
    self.date_publish ||= Time.zone.now
  end

  def post_views_count
    post_views.count
  end
  audited 
end