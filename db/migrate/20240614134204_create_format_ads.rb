class CreateFormatAds < ActiveRecord::Migration[7.0]
  def change
    create_table :format_ads do |t|
      t.string :title
      t.string :width
      t.string :height
      t.string :position

      t.timestamps
    end
  end
end
