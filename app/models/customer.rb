class Customer < ApplicationRecord
    has_many :orders, dependent: :destroy
  
    validates :name, presence: true
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :address, presence: true
    validates :city, presence: true
    validates :province, presence: true
    validates :postal_code, presence: true
  end