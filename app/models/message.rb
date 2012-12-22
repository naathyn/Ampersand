class Message < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user
  belongs_to :to, class_name: "User"

  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 2, maximum: 500 }

  before_save :alert_user

  default_scope order: 'messages.created_at DESC'

private

    def self.from_users_followed_by_including_private_messages(user)
      followed_user_ids = "SELECT followed_id FROM relationships
                           WHERE follower_id = :user_id"
      where("user_id IN (#{followed_user_ids}) OR user_id = :user_id OR to_id = :user_id", 
            user_id: user.id)
    end

    def alert_user
      if match = /\A!([^\s]*)/.match(content)
        user = User.find_by_name(match[1])
        self.to ||= user
        user = "<strong>!#{user.name}</strong>" if user
        self.content = "#{user} #{content.gsub(/\A!([^\s]*)/, '')}"
      end
    end
end
