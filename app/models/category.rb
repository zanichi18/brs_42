class Category < ApplicationRecord
  has_many :books, dependent: :destroy
  validates :name, presence: true, uniqueness: {case_sensitive: false},
    length: {maximum: Settings.category.name_max_length}

  scope :order_by_created_at_desc, ->{order created_at: :desc}
end
