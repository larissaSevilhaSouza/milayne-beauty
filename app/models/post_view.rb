class PostView < ApplicationRecord
  belongs_to :post
  audited
  
end
