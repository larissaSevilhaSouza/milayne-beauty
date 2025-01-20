class RemoveUniqueConstraintFromDatePublishInPosts < ActiveRecord::Migration[7.0]
    def change
      remove_index :posts, column: :date_publish, unique: true, name: "index_posts_on_date_publish"
      add_index :posts, :date_publish, name: "index_posts_on_date_publish"
    end
end
1