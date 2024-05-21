class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.decimal :price
      t.string :serial_number
      
      t.timestamps
    end
    add_index :products, :serial_number, unique: true
  end
end
