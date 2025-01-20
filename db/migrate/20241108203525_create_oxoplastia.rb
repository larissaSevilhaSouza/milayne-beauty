class CreateOxoplastia < ActiveRecord::Migration[7.0]
  def change
    create_table :oxoplastia do |t|
      t.string :photo
      t.string :text

      t.timestamps
    end
  end
end
