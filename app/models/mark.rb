class Mark < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :user, presence: true
  validates :book, presence: true

  scope :favorited, -> do
    where favorite: true
  end
  scope :by_book_id, -> book_id {find_by book_id: book_id}

  scope :reading_history, -> do
    read_reading = [Settings.mark_status.reading, Settings.mark_status.read]
    where "read_status IN #{read_reading}"
  end

  def next_status current_status
    next_status = current_status + 1
    if next_status >= Settings.user_book_status.count
      0
    else
      next_status
    end
  end
end
