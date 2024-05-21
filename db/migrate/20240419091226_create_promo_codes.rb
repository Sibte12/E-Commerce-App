class CreatePromoCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :promo_codes do |t|
      t.string :code
      t.decimal :discount_percentage
      t.date :valid_til

      t.timestamps
    end
  end
end
