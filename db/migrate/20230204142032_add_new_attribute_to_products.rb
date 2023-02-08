class AddNewAttributeToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :borrowed, :integer
  end
end
