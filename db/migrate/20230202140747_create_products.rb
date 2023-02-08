class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :price
      t.decimal :quantity
      t.decimal :borrowed

      t.timestamps
    end
  end
end
