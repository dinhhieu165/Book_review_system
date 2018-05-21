class Request < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :user, presence: true
  validates :book, presence: true
  enum status: [:waiting, :approved, :rejected]
end
