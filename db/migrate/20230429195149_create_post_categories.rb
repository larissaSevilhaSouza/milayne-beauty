class CreatePostCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :post_categories do |t|
      t.string :name
      t.string :slug
      
      t.timestamps
    end

    add_index :post_categories, :slug, unique: true
  end
end
