class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :cart_id, presence: true
  validates :product_id, presence: true

  attribute :quantity, :integer, default: 1
  

end
