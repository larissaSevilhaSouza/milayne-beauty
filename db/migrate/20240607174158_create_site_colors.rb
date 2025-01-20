class CreateSiteColors < ActiveRecord::Migration[7.0]
  def change
    create_table :site_colors do |t|
      t.string "primary", default: "#FFFFFF"
      t.string "sencondary", default: "#FFFFFF"
      t.string "terciary", default: "#FFFFFF" 
      t.string :logo_header
      t.string :logo_footer 
      t.timestamps
    end
  end
end
