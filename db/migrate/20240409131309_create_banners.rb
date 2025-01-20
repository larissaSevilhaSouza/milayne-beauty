class CreateBanners < ActiveRecord::Migration[7.0]
  def change
    create_table :banners do |t|
      t.string :title
      t.string :subtitle
      t.string :link
      t.string :photo

      t.timestamps
    end
  end
end
