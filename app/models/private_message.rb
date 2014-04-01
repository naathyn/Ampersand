class PrivateMessage < ActiveRecord::Base
  include PrivateMessagesHelper

  belongs_to :sender, foreign_key: "sender_id", class_name: "User"
  belongs_to :recipient, foreign_key: "recipient_id", class_name: "User"

  attr_accessor :to

  validates_presence_of :sender_id, :recipient_id, :content

  scope :read, -> { where("read_at IS NOT NULL") }
  scope :unread, -> { where("read_at IS NULL") }

  def timestamp
    DateTime.parse(created_at.to_s).strftime("%l:%M %p, %B %e")
  end

  def read_on
    DateTime.parse(read_at.to_s).strftime("%l:%M %p, %B %e")
  end

  def message_read?
    read_at.nil? ? false : true
  end

  def mark_deleted!(user)
    toggle!(:sender_deleted) if sender == user
    toggle!(:recipient_deleted) if recipient == user
    destroy! if sender_deleted && recipient_deleted
  end

private

  def self.read_message!(id, reader)
    message = where(["private_messages.id = ? AND (sender_id = (?) OR recipient_id = (?))",
      id, reader, reader]).first
    if message.read_at.nil? && reader == message.recipient
      message.read_at = Time.now
      message.save!
    end
    message
  end

  def self.sent_and_received_messages_archived_by(user)
    sender_deleted = "sender_id = :sender_id AND sender_deleted = :t"
    recipient_deleted = "recipient_id = :recipient_id AND recipient_deleted = :t"
    where("#{sender_deleted} OR (#{recipient_deleted})",
      sender_id: user.id, recipient_id: user.id, t: true).
      includes([:sender, :recipient])
  end
end
