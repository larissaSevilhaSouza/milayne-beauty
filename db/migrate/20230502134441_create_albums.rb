class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :title
      t.datetime :date_publish
      t.text :description
      t.string :slug
      t.boolean :featured, default: false
      t.references :album_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
