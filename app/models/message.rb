class Message < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user
  belongs_to :to, class_name: "User"

  validates_presence_of :user_id, :content
  validates_length_of :content, within: (2..500)

  default_scope order: 'created_at DESC'

private

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
        user_id: user.id)
    end
end
