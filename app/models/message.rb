class Message < ActiveRecord::Base
	attr_accessible :content, :to
	belongs_to :to, class_name: "User"
	belongs_to :user

	validates :micropost_id, presence: true
	validates :user_id, presence: true
  validates :content, presence: true

	default_scope order: 'messages.created_at DESC'

	private

  def self.from_users_followed_by_including_messages(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("to_id = :user_id", 
          user_id: user.id)
	end
end
