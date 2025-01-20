class Menu < ApplicationRecord
  has_many :sub_menus, dependent: :destroy
  accepts_nested_attributes_for :sub_menus, allow_destroy: true
  audited
  validates :name, :ordem, presence: :true
end
