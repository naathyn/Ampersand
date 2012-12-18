class Message < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user
  belongs_to :to, class_name: "User"

  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 2, maximum: 500 }

  before_save :chat_n_linkify

  default_scope order: 'messages.created_at DESC'

private

    def self.from_chatroom_users(user)
      followed_user_ids = "SELECT followed_id FROM relationships
                           WHERE follower_id = :user_id"
      where("user_id IN (#{followed_user_ids}) OR user_id = :user_id OR to_id = :user_id", 
            user_id: user.id)
    end

    def chat_n_linkify
      if match = /\A!([^\s]*)/.match(content)
        user = User.find_by_name(match[1])

        self.to ||= user

        user = "<strong>!#{user.name}</strong>" if user
        self.content = "#{user} #{content.gsub(/\A!([^\s]*)/, '')}"

        content = "#{content}"
        
      end
    end
end
