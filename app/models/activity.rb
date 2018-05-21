class Activity < ApplicationRecord
  belongs_to :user
  has_many :likes
  validate :user, presence: true
end
