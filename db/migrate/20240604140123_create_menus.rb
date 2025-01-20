class CreateMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :menus do |t|
      t.string :name
      t.string :link
      t.boolean :active
      t.boolean :active_link
      t.boolean :active_sub_menu

      t.timestamps
    end
  end
end
