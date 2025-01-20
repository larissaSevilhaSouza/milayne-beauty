class CreateStores < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :text
      t.string :description
      t.string :image

      t.timestamps
    end
  end
end
