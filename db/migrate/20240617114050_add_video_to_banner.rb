class AddVideoToBanner < ActiveRecord::Migration[7.0]
  def change
    add_column :banners, :video, :string
  end
end
