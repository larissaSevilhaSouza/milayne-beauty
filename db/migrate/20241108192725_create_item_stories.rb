class CreateItemStories < ActiveRecord::Migration[7.0]
  def change
    create_table :item_stories do |t|
      t.string :name
      t.string :description
      t.references :category_stores, null: false, foreign_key: true

      t.timestamps
    end
  end
end
