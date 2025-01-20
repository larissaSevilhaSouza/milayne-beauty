class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :summary
      t.string :written_by
      t.string :source
      t.string :cover
      t.string :slug
      t.datetime :date_publish
      t.text :content
      t.boolean :featured
      t.boolean :is_published, :default => false
      t.references :post_category, null: false, foreign_key: true

      t.timestamps
    end

    add_index :posts, :slug, unique: true
    add_index :posts, :date_publish, unique: true
  end
end
