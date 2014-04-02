class PrivateMessage < ActiveRecord::Base

  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  attr_accessor :to

  validates_presence_of :sender_id, :recipient_id, :content

  scope :read, -> { where("read_at IS NOT NULL") }
  scope :unread, -> { where("read_at IS NULL") }

  def timestamp
    DateTime.parse(created_at.to_s).strftime("%B %e at %l:%M %p")
  end

  def read_on
    DateTime.parse(read_at.to_s).strftime("%B %e at %l:%M %p")
  end

  def message_read?
    read_at.nil? ? false : true
  end

private

  self.per_page = 10

  def self.sent_and_received_messages_archived_by(user)
    sender_deleted = "sender_id = :sender_id AND sender_deleted = :t"
    recipient_deleted = "recipient_id = :recipient_id AND recipient_deleted = :t"
    where("#{sender_deleted} OR (#{recipient_deleted})",
      sender_id: user.id, recipient_id: user.id, t: true).
      includes([:sender, :recipient])
  end
end
