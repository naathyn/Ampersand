class Message < ActiveRecord::Base
  attr_accessible :convo

  belongs_to :user
  belongs_to :to, class_name: "User"

  validates :user_id, presence: true

  VALID_MESSAGE = /\A!([^\s*][a-z\d_.]{5,15}+\s*\w\W)+([\s\w\W]{0,250})\Z/i
  validates :convo, presence: true, length: { maximum: 255 },
  format: { with: VALID_MESSAGE }

  default_scope order: 'messages.created_at DESC'
  before_create :send_message

private

  def self.from_users_inbox(user)
    where("user_id = :user_id OR to_id = :user_id", user_id: user.id)
  end

  MESSAGE_REGEX = /\A!([^\s]*)/
  def send_message
    if match = MESSAGE_REGEX.match(convo)
      user = User.find_by_name(match[1])
      self.to ||= user
    end
  end
end
