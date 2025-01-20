class CreateAdjustments < ActiveRecord::Migration[7.0]
  def change
    create_table :adjustments do |t|
      t.string :phone
      t.string :adress
      t.string :email

      t.timestamps
    end
  end
end
