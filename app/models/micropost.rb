class Micropost < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user
  belongs_to :to, class_name: "User"

  has_many :opinions, foreign_key: "like_id", dependent: :destroy
  has_many :likes, through: :opinions
  has_many :fans, through: :opinions

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }

  default_scope order: 'microposts.created_at DESC'
  before_create :send_reply

private

  def self.from_users_profile(user)
    where("user_id = :user_id", user_id: user.id)
  end

  def self.from_users_replies(user)
    where("to_id = :user_id", user_id: user.id)
  end

  def self.from_users_shares(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end

  REPLY_REGEX = /\A@([^\s]*)/
  def send_reply
    if match = REPLY_REGEX.match(content)
      user = User.find_by_name(match[1])
      self.to ||= user
    end
  end
end
