class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product_name
      t.float :price
      t.string :description
      t.integer :quantity
      t.string :images
      t.string :rating
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end

  end
end
