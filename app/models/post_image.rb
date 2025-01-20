class PostImage < ApplicationRecord
  mount_uploader :url, PostImageUploader
  belongs_to :post, optional: true
  belongs_to :page, optional: true
  audited
  
end
