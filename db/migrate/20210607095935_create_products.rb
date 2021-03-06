class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :sku
      t.string :name
      t.text :description
      t.references :product_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
