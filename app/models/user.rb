class User < ActiveRecord::Base
  attr_accessible :realname, :email, :name, :location, :bio,
                  :password, :password_confirmation, :sign_in_count, :website

  EAGER_LOADING   = [:likes, :fans, user: { captchas: {user: :fans} }]
  VALID_REALNAME  = /\A([A-Z]*\s+[a-zA-Z]*)\Z/i
  VALID_USERNAME  = /\A[A-Z\d_]*\Z/i
  VALID_WEBSITE   = /^(http|https):\/\/|[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/ix

  has_secure_password
  has_many :captchas, dependent: :destroy
  has_many :microposts, dependent: :destroy, include: EAGER_LOADING
  has_many :replies, foreign_key: "to_id", class_name: "Micropost", dependent: :destroy,
    include: EAGER_LOADING
  has_many :fans, foreign_key: "fan_id", class_name: "Opinion", dependent: :destroy
  has_many :likes, through: :fans
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                    class_name: "Relationship",
                                    dependent: :destroy
  has_many :followers, through: :reverse_relationships
  has_many :blogs, dependent: :destroy
  has_many :taggings, through: :blogs, source: :tags, uniq: true
  has_many :comments, dependent: :destroy
  has_many :messages, dependent: :delete_all

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
  validates_format_of :website, with: VALID_WEBSITE, allow_blank: true, allow_nil: true

  before_save { email.downcase! }
  before_save { name.downcase! }
  before_save :create_remember_token

  def share
    Micropost.from_users_followed_by(self)
  end

  def chat
    Message.from_users_followed_by(self)
  end

  def random_captcha
    captchas.shuffle.last
  end

  def random_post
    microposts.shuffle.last
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
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
