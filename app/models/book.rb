class Book < ApplicationRecord
  belongs_to :category
  has_many :rates, dependent: :destroy
  has_many :marks, dependent: :destroy
  has_many :reviews, dependent: :destroy
end
