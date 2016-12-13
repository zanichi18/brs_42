class Mark < ApplicationRecord
  belongs_to :book
  belongs_to :user

  enum mark_type: [:unread, :read, :reading]
end
