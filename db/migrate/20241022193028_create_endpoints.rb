# frozen_string_literal: true

class CreateEndpoints < ActiveRecord::Migration[7.2]
  def change
    create_table :endpoints do |t|
      t.string :url, null: false
      t.references :shop, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :endpoints, :url, unique: true
  end
end
