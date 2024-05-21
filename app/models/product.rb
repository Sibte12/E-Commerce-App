class Product < ApplicationRecord
  belongs_to :user
  has_many :images
  has_many :comments
  has_many :cart_items
  has_many :order_items

  before_validation :generate_serial_number
  
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :price, presence: true

  validates :serial_number, presence: true


  private

  def generate_serial_number
    self.serial_number = SecureRandom.hex(4).upcase
    puts "Generated Serial Number: #{self.serial_number}"
  end
end
