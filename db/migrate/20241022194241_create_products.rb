# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :amount, null: false
      t.string :url_to_shop, null: false
      t.integer :status, null: false, default: 0
      t.integer :price, null: false
      t.integer :discount_price
      t.date :discount_expires_on
      t.integer :discount_rate
      t.float :alcohol_rate
      t.references :shop, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :products, :name
    add_index :products, :url_to_shop, unique: true
  end
end
