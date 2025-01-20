class Album < ApplicationRecord
  include PgSearch::Model
  
  validates :title, :date_publish, :album_category, presence: true

  belongs_to :album_category

  has_many :photos, dependent: :destroy 

  has_and_belongs_to_many :post, inverse_of: :album
  has_and_belongs_to_many :pages, inverse_of: :album

  accepts_nested_attributes_for :photos, allow_destroy: true


  pg_search_scope :search_title, against: :title, order_within_rank: "albums.updated_at DESC"
  
  audited

  extend FriendlyId
    friendly_id :title, use: :slugged

  def cover_photo
    cover_photos = photos.where(cover: true)
  
    if cover_photos.any?
      cover_photos.first.image
    else
      photos.order(created_at: :asc).first.image
    end
  end

  def date
    date_publish.strftime("%d/%m/%Y")
  end

end
