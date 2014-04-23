class PrivateMessage < ActiveRecord::Base
  include PrivateMessagesHelper

  attr_accessor :to

  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  validates_presence_of :sender_id, :recipient_id, :content

  default_scope -> { order('created_at DESC') }
  scope :unread, -> { where("read_at IS NULL") }

private

  self.per_page = 10

  def self.archived_by(user)
    recipient_deleted = "recipient_id = :user_id AND recipient_deleted = :t"
    sender_deleted = "sender_id = :user_id AND sender_deleted = :t"
    includes(:recipient, :sender).where("#{recipient_deleted} OR (#{sender_deleted})",
      user_id: user.id, t: true)
  end
end
