class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  scope :created_desc, ->{order created_at: :desc}

  validates :content, presence: true
  validates :user_id, presence: true
  validates :book_id, presence: true

  def list_users_like_review
    User.of_ids Like.ids_user_of_review self.id
  end

  def is_liked_by? user
    self.list_users_like_review.include? user
  end
end
