class CreateInventoryModifications < ActiveRecord::Migration[5.2]
  def change
    create_table :inventory_modifications do |t|
      t.integer :quantity_added
      t.integer :quantity_removed
      t.date :date
      t.references :inventory, foreign_key: true

      t.timestamps
    end
  end
end
