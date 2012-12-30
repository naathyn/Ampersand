class User < ActiveRecord::Base 
  attr_accessible :realname, :email, :name, :location, :bio, 
  :password, :password_confirmation, :sign_in_count

  has_secure_password

  has_many :captchas, dependent: :destroy

  has_many :microposts, dependent: :destroy
  has_many :replies, foreign_key: "to_id", class_name: "Micropost", dependent: :destroy

  has_many :fans, foreign_key: "fan_id", class_name: "Opinion", dependent: :destroy

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                    class_name: "Relationship",
                                    dependent: :destroy
  has_many :followers, through: :reverse_relationships

  has_many :messages, dependent: :delete_all
  has_many :private_messages, foreign_key: "to_id", class_name: "Message", dependent: :delete_all

  VALID_REALNAME = /\A([a-zA-Z]*\s+[a-zA-Z]*)\Z/i
  VALID_USERNAME = /\A[a-z\d_]*\Z/i

  validates_presence_of :realname, :email, :name
  validates_uniqueness_of :realname, :email, :name, case_sensitive: false

  validates_length_of :realname, within: (2..20)
  validates_length_of :name, within: (5..15)
  validates_length_of :location, maximum: 50
  validates_length_of :bio, maximum: 255

  validates_length_of :password, minimum: 6
  validates_confirmation_of :password_confirmation

  validates_format_of :realname, with: VALID_REALNAME
  validates_format_of :name, with: VALID_USERNAME

  before_save { |user| user.email = email.downcase }
  before_save { |user| user.name = name.downcase }
  before_save :create_remember_token

  def share
    Micropost.from_users_followed_by(self)
  end

  def chat
    Message.from_users_followed_by_including_private_messages(self)
  end

  def random_captcha
    self.captchas.shuffle!
    self.captchas.last
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def liked?(random_share)
    fans.find_by_like_id(random_share.id)
  end

  def like!(random_share)
    fans.create!(like_id: random_share.id)
  end

  def unlike!(random_share)
    fans.find_by_like_id(random_share.id).destroy
  end

  def to_param
    name
  end

protected

    def create_remember_token
      self.remember_token = SecureRandom.uuid
    end
end
