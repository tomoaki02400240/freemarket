class Product < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :user_likes
  validates :name, presence: true
  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :category_id, presence: true
  validates :description, presence: true
  
 
end
