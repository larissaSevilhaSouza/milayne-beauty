class CreatePostViews < ActiveRecord::Migration[7.0]
  def change
    create_table :post_views do |t|
      t.references :post, null: false, foreign_key: true
      t.string :ip_address

      t.timestamps
    end

    add_index :post_views, :created_at
  end
end
