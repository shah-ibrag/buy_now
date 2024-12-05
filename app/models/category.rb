class Category < ApplicationRecord
  has_many :products

  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }
end