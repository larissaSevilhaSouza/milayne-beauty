class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.datetime :date_publish
      t.string :url
      t.string :description
      t.string :slug
      t.boolean :featured, default: false

      t.timestamps
    end
  end
end
