class CreateItemsBorroweds < ActiveRecord::Migration[7.0]
  def change
    create_table :items_borroweds do |t|
      t.string :title
      t.datetime :date
      t.integer :numer
      t.boolean :given

      t.timestamps
    end
  end
end
