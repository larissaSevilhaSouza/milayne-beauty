class ChangeFeaturedDefaultOnPost < ActiveRecord::Migration[7.0]
  def change
    change_column_default :posts, :featured, from: nil, to: false
  end
end
