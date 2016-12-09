class Book < ApplicationRecord
  belongs_to :category
  has_many :rates, dependent: :destroy
  has_many :marks, dependent: :destroy
  has_many :reviews, dependent: :destroy

  scope :order_created_at, ->{order created_at: :desc}
end
