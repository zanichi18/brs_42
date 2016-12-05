class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
end
