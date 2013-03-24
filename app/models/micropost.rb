class Micropost < ActiveRecord::Base
  attr_accessible :content

  USERNAME_RE = /\A@([^\s]*)/

  belongs_to :user
  belongs_to :to, class_name: "User"

  has_many :likes, foreign_key: "like_id", class_name: "Opinion", dependent: :destroy
  has_many :fans, through: :likes

  validates_presence_of :user_id, :content
  validates_length_of :content, within: (5..800)

  before_save :link_username
  before_save { |micropost| micropost.content.gsub!(/\n/, '<br>') }

  default_scope order: "created_at DESC"

  def liked_by?(fan)
    likes.find_by_fan_id(fan.id)
  end

  def timestamp
    self.created_at.to_s(:long_ordinal).gsub(/\d+:\d+/, '')
  end

private

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
      where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
        user_id: user.id)
  end

  def link_username
    if match = USERNAME_RE.match(content)
      user = User.find_by_name(match[1])
      self.to = user
      user = "<a href='/users/#{user.name}'>@#{user.name}</a>" if user
      self.content = "#{user} #{content.gsub(USERNAME_RE,'')}"
    end
  end

  self.per_page = 20
end
