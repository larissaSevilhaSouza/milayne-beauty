class CreateAbouts < ActiveRecord::Migration[7.0]
  def change
    create_table :abouts do |t|
      t.string :sumary
      t.string :text
      t.string :photo

      t.timestamps
    end
  end
end
