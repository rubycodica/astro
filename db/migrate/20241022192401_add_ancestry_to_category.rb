# frozen_string_literal: true

class AddAncestryToCategory < ActiveRecord::Migration[7.2]
  def up
    change_table :categories, bulk: true do |t|
      t.column :ancestry, :string, collation: 'C', null: false, default: '/'
      t.index  :ancestry
    end
  end

  def down
    change_table :categories, bulk: true do |t|
      t.remove_index :ancestry
      t.remove       :ancestry
    end
  end
end
