class CreateAdsenses < ActiveRecord::Migration[7.0]
  def change
    create_table :adsenses do |t|
      t.string :title
      t.integer :ad_type
      t.text :script
      t.boolean :status

      t.timestamps
    end
  end
end
