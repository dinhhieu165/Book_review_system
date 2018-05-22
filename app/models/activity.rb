class Activity < ApplicationRecord
  belongs_to :user
  has_many :likes
  validates :user, presence: true

  scope :by_following_from, -> user_id do
    following_ids = User.find_by(id: user_id)
      &.followings
      &.map(&:id)
      &.join(",")
    where("user_id IN (#{following_ids})") if following_ids.present?
    order created_at: :desc
  end

  scope :recent, -> do
    order created_at: :desc
  end

  def activity_text
    case action_type
    when Settings.activity.action_type.follow_user
      I18n.t "activity.content.follow_user",
        name: target_user&.name
    when Settings.activity.action_type.followed_by_user
      I18n.t "activity.content.followed_by_user",
        name: target_user&.name
    when Settings.activity.action_type.mark_read
      I18n.t "activity.content.mark_read",
        name: target_book&.title
    when Settings.activity.action_type.mark_reading
      I18n.t "activity.content.mark_reading",
        name: target_book&.title
    when Settings.activity.action_type.mark_favorites
      I18n.t "activity.content.mark_favorite",
        name: target_book&.title
    when Settings.activity.action_type.write_review
      I18n.t "activity.content.write_review",
        name: target_book&.title
    when Settings.activity.action_type.write_comment
      I18n.t "activity.content.write_comment",
        name: target_book&.title
    end
  end

  def is_target_book?
    [
      Settings.activity.action_type.mark_read,
      Settings.activity.action_type.mark_reading,
      Settings.activity.action_type.mark_favorites,
      Settings.activity.action_type.write_review,
      Settings.activity.action_type.write_comment
    ].include? action_type
  end

  def target_book
    Book.find_by id: target_id
  end

  def target_user
    User.find_by id: target_id
  end
end
