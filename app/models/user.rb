class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

end
