class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  FEED_EAGER_LOADING = [:likes, :fans, user: { captchas: {user: :fans} }]
  BLOG_EAGER_LOADING = [:tags, :user]
  MAILBOX_EAGER_LOADING = [:sender, :recipient]

  VALID_REALNAME  = /\A([a-z]+\s*[a-z]+)\z/i
  VALID_USERNAME  = /\A[a-z\d_]+\z/i
  VALID_WEBSITE   = /\A(http|https):\/\/|[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?\z/i

  has_secure_password

  has_many :captchas, dependent: :destroy
  has_many :microposts, dependent: :destroy

  has_many :replies, foreign_key: "to_id", class_name: "Micropost", dependent: :destroy

  has_many :fans, foreign_key: "fan_id", class_name: "Opinion", dependent: :destroy
  has_many :likes, through: :fans

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id",
                                    class_name: "Relationship",
                                    dependent: :destroy
  has_many :followers, through: :reverse_relationships


  has_many :sent_messages, -> { includes(:recipient) },
                              foreign_key: 'sender_id',
                              class_name: "PrivateMessage",
                              dependent: :destroy

  has_many :received_messages, -> { includes(:sender) },
                                  foreign_key: 'recipient_id',
                                  class_name: "PrivateMessage",
                                  dependent: :destroy

  has_many :blogs, dependent: :destroy
  has_many :tags, through: :blogs

  has_many :comments, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates_presence_of :realname, :email, :name
  validates_uniqueness_of :realname, :email, :name, case_sensitive: false

  validates_length_of :realname, within: (2..20)
  validates_length_of :name, within: (5..15)
  validates_length_of :location, maximum: 50
  validates_length_of :bio, maximum: 255

  validates_length_of :password, minimum: 6, if: :password_digest_changed?
  validates_presence_of :password_confirmation, if: :password_digest_changed?

  validates_format_of :realname, with: VALID_REALNAME
  validates_format_of :name, with: VALID_USERNAME
  validates_format_of :website, with: VALID_WEBSITE,
    allow_blank: true, allow_nil: true

  before_save { email.downcase! }
  before_save { name.downcase! }
  before_save { |user| user.realname = realname.titleize }
  before_save :create_remember_token

  def username
    "@#{name}"
  end

  def share
    Micropost.includes(FEED_EAGER_LOADING).from_users_followed_by(self)
  end

  def trash
    PrivateMessage.includes(MAILBOX_EAGER_LOADING).archived_by(self)
  end

  def outbox
    sent_messages.includes(:sender).where("sender_deleted = :f", f: false)
  end

  def inbox
    received_messages.includes(:recipient).where("recipient_deleted = :f", f: false)
  end

  def unread_messages
    inbox.unread
  end

  def unread_message_count
    @unread_message_count ||= unread_messages.size
  end

  def read!(message)
    message = PrivateMessage.includes(MAILBOX_EAGER_LOADING).find(message)
    if message.recipient == self && message.read_at.nil?
      message.read_at = Time.now
      message.save!
    end
    message
  end

  def delete!(message)
    message = PrivateMessage.find(message)
    message.toggle!(:sender_deleted) if message.sender == self
    message.toggle!(:recipient_deleted) if message.recipient == self
    message.destroy! if message.sender_deleted && message.recipient_deleted
  end

  def random_captcha
    captchas.shuffle.first
  end

  def random_post
    microposts.shuffle.first
  end

  def following?(user)
    relationships.find_by(followed_id: user.id)
  end

  def following?(user)
    relationships.find_by(followed_id: user.id)
  end

  def follow!(user)
    relationships.create!(followed_id: user.id)
  end

  def unfollow!(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  def like!(micropost)
    fans.create!(like_id: micropost.id)
  end

  def unlike!(micropost)
    fans.find_by(like_id: micropost.id).destroy
  end

  def known_location
    location.present? ? location : "Unknown"
  end

private

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.secure(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.secure_new_token
    secure(new_token)
  end

  def create_remember_token
    self.remember_token = User.secure_new_token
  end
end
