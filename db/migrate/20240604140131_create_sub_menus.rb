class CreateSubMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :sub_menus do |t|
      t.string :name
      t.string :link
      t.boolean :new_page
      t.references :menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
