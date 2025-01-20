class CreatePhotoItens < ActiveRecord::Migration[7.0]
  def change
    create_table :photo_itens do |t|
      t.string :photo
      t.references :item_stories, null: false, foreign_key: true

      t.timestamps
    end
  end
end
