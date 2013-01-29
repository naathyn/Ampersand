class Micropost < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user
  belongs_to :to, class_name: "User"

  has_many :likes, foreign_key: "like_id", class_name: "Opinion", dependent: :destroy
  has_many :fans, through: :likes

  validates_presence_of :user_id, :content
  validates_length_of :content, within: (5..800)

  after_validation :reply_n_linkify

  default_scope order: "created_at DESC"

  def fan_likes_count
    unless likes.empty?
      likes.count
    else
      0
    end
  end

  def liked_by?(fan)
    likes.find_by_fan_id(fan.id)
  end

private

  self.per_page = 20

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end

  def reply_n_linkify
    if match = /\A@([^\s]*)/.match(content)
      user = User.find_by_name(match[1])
      self.to ||= user
      user = "<a href='/users/#{user.name}'>@#{user.name}</a>" if user
      self.content = "#{user} #{content.gsub(/\A@([^\s]*)/,'')}"
    end
  end
end
