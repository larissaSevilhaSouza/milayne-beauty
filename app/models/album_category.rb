class AlbumCategory < ApplicationRecord
  has_many :albums
  audited
  validates :name, presence: :true
end
