class ChangeAttributeType < ActiveRecord::Migration[7.0]
  def change
    change_column :products, :borrowed, :integer
  end
end
