class AddPhoneToContact < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :phone, :string
  end
end
