class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  ROLES = %w[user admin].freeze

  # Check if the user is an admin
  def admin?
    role == "admin"
  end
end