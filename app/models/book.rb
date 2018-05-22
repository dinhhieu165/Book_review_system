class Book < ApplicationRecord
  ratyrate_rateable "quality", "content"
  belongs_to :category
  has_many :marks
  has_many :requests
  has_many :reviews

  has_attached_file :image
  validates_attachment :image,
                       content_type: {content_type: /\Aimage\/.*\z/},
                       size: { less_than: 1.megabyte}
  validates :number_of_pages, presence: true
  validates :title, presence: true, length: {minimum: 3, maximum: 100}
  validates :author, presence: true
  validates :description, presence: true, length: {minimum: 10}
  validates :publish_date, presence: true

  scope :of_category, -> category_id do
    where category_id: category_id if category_id.present?
  end

  def is_favorite_of_user? user
    user.marks.favorited&.map(&:book_id)&.include? id
  end

  def is_reading_of_user? user
    if user.marks.find_by(book_id: id).nil?
      false
    else
      user.marks.by_book_id(id).status == Settings.user_book_status.reading
    end
  end

  def is_read_of_user? user
    if user.marks.find_by(book_id: id).nil?
      false
    else
      user.marks.by_book_id(id).status == Settings.user_book_status.read
    end
  end

  def next_status_of_user user, target_status
    if user.marks.find_by(book_id: id).nil?
      source_status = nil
    else
      source_status = user.marks.by_book_id(id).status
    end
    if source_status == target_status
      Settings.user_book_status.no_status
    else
      target_status
    end
  end
end
