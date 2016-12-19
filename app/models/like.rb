class Like < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :user_id, presence: true
  validates :review_id, presence: true

  scope :ids_user_of_review, -> review_id do
    where(review_id: review_id).pluck :user_id
  end
end
