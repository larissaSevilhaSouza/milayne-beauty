class AddFormatAdToBanners < ActiveRecord::Migration[7.0]
  def change
    add_reference :banners, :format_ad, foreign_key: true
  end
end
