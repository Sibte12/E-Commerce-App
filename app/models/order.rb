class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  belongs_to :promo_code, optional: true

  validates :user_id, presence: true
  validates :total_amount, numericality: { greater_than_or_equal_to: 0 }
  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= 'in_progress'
  end

end
