class User < ApplicationRecord
  has_secure_password
  has_many :orders

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }
  validates :password, presence: true, length: { minimum: 6 }
end