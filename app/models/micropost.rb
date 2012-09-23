class Micropost < ActiveRecord::Base
  attr_accessible :content, :to
  belongs_to :user
	belongs_to :to, class_name: "User"
	
	validates :user_id, presence: true
	validates :content, presence: true, length: { maximum: 300 }

	before_save :send_reply_to

	default_scope order: 'microposts.created_at DESC'

  def self.from_users_followed_by_including_replies(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id OR to_id = :user_id", 
          user_id: user.id)
  end

	TO_ID_REGEX = /\A@([^\s]*)/
  def send_reply_to
    if match = TO_ID_REGEX.match(content)
      user = User.find_by_romania(match[1])
      self.to=user if user
		end
	end
end
