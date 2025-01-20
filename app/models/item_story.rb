class ItemStory < ApplicationRecord
  has_many :category_store
  has_many :photo_itens, dependent: :destroy  
  accepts_nested_attributes_for :photo_itens, allow_destroy: true
end
