class CreateCategoryFonts < ActiveRecord::Migration[7.0]
  def change
    create_table :category_fonts do |t|
      t.string :title

      t.timestamps
    end
  end
end
