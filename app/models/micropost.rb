class Micropost < ActiveRecord::Base
  attr_accessible :content, :to

  belongs_to :user
	belongs_to :to, class_name: "User"

	has_many :opinions, foreign_key: "like_id", dependent: :destroy
  has_many :likes, through: :opinions, source: :like
  # has_many :agreeables, foreign_key: "fan_id", class_name: "Opinion", dependent: :destroy #
  # has_many :fans, through: :agreeables #

	validates :user_id, presence: true
	validates :content, presence: true, length: { maximum: 255 }

	default_scope order: 'microposts.created_at DESC'
	before_save :send_reply

	#def fans
	#	Micropost.from_fan_likes(self)
	#end

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

  #def self.from_fan_likes(micropost)
  #  fan_ids = "SELECT fan_id FROM opinions WHERE like_id = :like_id"
  #  where("user_id IN (#{fan_ids})", like_id: micropost.id)
  #end

	REPLY_REGEX = /\A@([^\s]*)/
  def send_reply
    if match = REPLY_REGEX.match(content)
      user = User.find_by_regex(match[1])
      self.to = user
		end
	end
end
