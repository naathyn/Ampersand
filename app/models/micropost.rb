class Micropost < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user
  belongs_to :to, class_name: "User"

  has_many :likes, foreign_key: "like_id", class_name: "Opinion", dependent: :destroy
  has_many :fans, through: :likes

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }

  before_save :reply_n_linkify

  default_scope order: 'microposts.created_at DESC'

private

    def self.from_users_followed_by(user)
      followed_user_ids = "SELECT followed_id FROM relationships
                           WHERE follower_id = :user_id"
      where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
            user_id: user.id)
    end

    REPLY_REGEX = /\A@([^\s]*)/
    def reply_n_linkify
      if match = REPLY_REGEX.match(content)
        user = User.find_by_name(match[1])
        self.to ||= user

        user = "<a href='/users/#{to.id}'>@#{user.name}</a>" if user
        self.content = "#{user} #{content.gsub(REPLY_REGEX, '')}"
      end
    end
end
