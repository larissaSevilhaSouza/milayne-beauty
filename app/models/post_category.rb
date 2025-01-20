class PostCategory < ApplicationRecord
  extend FriendlyId
  
  friendly_id :name, use: [:slugged, :finders]
  def should_generate_new_friendly_id?
    name_changed?
  end

  has_many :posts
  
  audited
  
  include PgSearch::Model
  
  pg_search_scope :search_title, against: :name, order_within_rank: "post_categories.updated_at DESC"
end
