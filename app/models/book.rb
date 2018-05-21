class Book < ApplicationRecord
  belongs_to :category
  has_many :marks
  has_many :requests
  has_many :reviews

  validates :number_of_pages, presence: true
  validates :title, presence: true, length: {minimum: 10, maximum: 100}
  validates :author, presence: true
  validates :description, presence: true, length: {minimum: 10}
  validates :publish_date, presence: true
end
