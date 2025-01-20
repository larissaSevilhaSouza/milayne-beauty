class JoinTableAlbumsPosts < ActiveRecord::Migration[7.0]
  def change
    create_join_table :albums, :posts do |t|
      t.index [:album_id, :post_id], :name => 'index_album_post'
      t.index [:post_id, :album_id], :name => 'index_post_album'
    end
  end
end
