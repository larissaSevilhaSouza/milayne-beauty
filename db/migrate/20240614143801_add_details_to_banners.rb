class AddDetailsToBanners < ActiveRecord::Migration[7.0]
  def change
    add_column :banners, :code_slot_adsense, :string
    add_column :banners, :code_client_adsense, :string
    add_column :banners, :start_date, :datetime
    add_column :banners, :finish_date, :datetime
    add_column :banners, :file_ad, :string
  end
end
