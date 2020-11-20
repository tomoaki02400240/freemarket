class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }, on: :create
  validates :password, presence: true, length: { minimum: 8 }, on: :update, allow_blank: true
  has_secure_password
  
  has_many :products, dependent: :destroy
  has_many :user_likes, dependent: :destroy
  
  def like_from?(product)
    self.user_likes.exists?(product_id: product.id)
  end
  def password_exist?
    self.password.present?  
  end
  
end
