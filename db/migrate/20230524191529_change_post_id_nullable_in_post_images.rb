class ChangePostIdNullableInPostImages < ActiveRecord::Migration[7.0]
  def change
    change_column_null :post_images, :post_id, true
  end
end
