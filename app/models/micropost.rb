class Micropost < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user
  belongs_to :to, class_name: "User"

  has_many :likes, foreign_key: "like_id", class_name: "Opinion", dependent: :destroy
  has_many :fans, through: :likes

  has_many :tags, dependent: :destroy
  has_many :hashtags, through: :tags

  validates_presence_of :user_id, :content
  validates_length_of :content, within: (5..800)

  after_validation :reply_n_linkify
  after_save :arrange_hashtags

  default_scope order: 'created_at DESC'

  def fan_likes_count
    unless likes.empty?
      likes.count
    else
    0
    end
  end

  def liked_by?(user)
    likes.find_by_fan_id(user.id)
  end

private

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

    def arrange_hashtags
      if match = /\#([^\s]*)/.match(content)
        self.hashtags = content.split(/\#([^\s]*)/).map do |name|
        Hashtag.find_or_create_by_name(name)
      end
    end
  end
end
