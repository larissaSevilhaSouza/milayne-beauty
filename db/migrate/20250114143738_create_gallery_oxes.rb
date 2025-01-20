class CreateGalleryOxes < ActiveRecord::Migration[7.0]
  def change
    create_table :gallery_oxes do |t|
      t.string :photo
      t.references :oxoplastium, null: false, foreign_key: true

      t.timestamps
    end
  end
end
