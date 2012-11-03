class Micropost < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user
  belongs_to :to, class_name: "User"

  has_many :replies, foreign_key: "to_id", class_name: "Micropost"
  has_many :opinions, foreign_key: "like_id", dependent: :destroy
  has_many :likes, through: :opinions
  has_many :fans, through: :opinions

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }

  default_scope order: 'microposts.created_at DESC'
  before_save :send_reply

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

  @@reply_regex = /\A@([^\s]*)/
  def send_reply
    if match = @@reply_regex.match(content)
      user = User.find_by_name(match[1])
      self.to = user if user
    end
  end
end
