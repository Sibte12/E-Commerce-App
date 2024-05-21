class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :total_amount
      t.string :status
      t.references :promo_code, null: false, foreign_key: true

      t.timestamps
    end
  end
end
