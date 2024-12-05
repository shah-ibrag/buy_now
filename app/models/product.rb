class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items
  has_one_attached :image

  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :category_id, presence: true
end