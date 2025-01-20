class CreateLinkTops < ActiveRecord::Migration[7.0]
  def change
    create_table :link_tops do |t|
      t.string :icon
      t.string :link
      t.string :name
      t.boolean :new_page
      
      t.timestamps
    end
  end
end
