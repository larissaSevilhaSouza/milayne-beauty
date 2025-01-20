class AddStatusToBanner < ActiveRecord::Migration[7.0]
  def change
    add_column :banners, :status, :boolean
  end
end
