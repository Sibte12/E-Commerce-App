class PromoCode < ApplicationRecord
    has_many :orders

    validates :code, presence: true, uniqueness: true
    validates :discount_percentage, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
    validates :valid_til, presence: true
    
end
