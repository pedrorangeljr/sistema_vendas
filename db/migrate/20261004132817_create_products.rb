class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.references :category, null: false, foreign_key: true

      t.string :name, null: false
      t.string :sku, null: false
      t.text :description

      t.decimal :cost_price, precision: 10, scale: 2, null: false
      t.decimal :price, precision: 10, scale: 2, null: false

      t.integer :stock_quantity, null: false, default: 0
      t.integer :minimum_stock, null: false, default: 0

      t.boolean :active, null: false, default: true

      t.timestamps
    end

    add_index :products, :sku, unique: true
  end
end
