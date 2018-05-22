class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  enum admin: {user: 0, admin: 1}
  ratyrate_rater
  has_many :reviews
  has_many :comments
  has_many :requests
  has_many :activities
  has_many :marks
  has_many :likes

  has_many :active_relationships, class_name: Relationship.name, foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name, foreign_key: "followed_id", dependent: :destroy

  has_many :followers, through: :active_relationships, source: :followed
  has_many :followings, through: :passive_relationships, source: :follower
  scope :has_name, ->(keyword) {where("name LIKE ?", "%#{keyword}%")}

  def is_user? current_user
    current_user == self
  end

  def is_admin?
    admin == Settings.role[:admin]
  end

  def has_requested book_id
    !self.requests.find_by(book_id: book_id).nil?
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    followings.include? other_user
  end

  class << self
    def from_omniauth auth
      where(provider: auth.provider, uid: auth.id).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
      end
    end

    def new_with_session params, session
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["row_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
  end
end
