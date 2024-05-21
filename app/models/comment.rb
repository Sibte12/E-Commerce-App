class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user, presence: true
  validates :product, presence: true
  validates :content, presence: true
  
  validate :user_cannot_buy_own_product

  private


  def user_cannot_buy_own_product
    if user && user_id == product.user_id
      errors.add(:user, "cannot buy their own product")
    end
  end
end
