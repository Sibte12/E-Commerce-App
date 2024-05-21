class ChangePromoCodeNullConstraintInOrders < ActiveRecord::Migration[7.1]
  def change
    change_column_null :orders, :promo_code_id, true
  end
end
