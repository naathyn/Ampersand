class Micropost < ActiveRecord::Base
  attr_accessible :content, :to
  belongs_to :user
	belongs_to :to, class_name: "User"

	default_scope order: 'microposts.created_at DESC'
	before_save :send_reply
	
	validates :user_id, presence: true
	validates :content, presence: true, length: { maximum: 500 }

private

  def self.from_users(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id = :user_id", user_id: user.id)
  end

  def self.from_users_including_replies(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("to_id = :user_id", user_id: user.id)
  end

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end

  def self.from_users_followed_by_including_replies(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id OR to_id = :user_id", 
          user_id: user.id)
  end

	REPLY_REGEX = /\A@([^\s]*)/
  def send_reply
    if match = REPLY_REGEX.match(content)
      user = User.find_by_regex(match[1])
      self.to ||= user
		end
	end
end
