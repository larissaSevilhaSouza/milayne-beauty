class AddCategoryToBanner < ActiveRecord::Migration[7.0]
  def change
    add_column :banners, :category, :integer
  end
end
