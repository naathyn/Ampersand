class User < ActiveRecord::Base 
  attr_accessible :realname, :email, :name, :location, :bio, 
  :password, :password_confirmation, :sign_in_count

  has_secure_password

  has_many :captchas, dependent: :destroy

  has_many :microposts, dependent: :destroy
  has_many :replies, foreign_key: "to_id", class_name: "Micropost", dependent: :destroy

  has_many :opinions, foreign_key: "fan_id", class_name: "Opinion", dependent: :destroy

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                    class_name: "Relationship",
                                    dependent: :destroy
  has_many :followers, through: :reverse_relationships

  has_many :messages, dependent: :delete_all
  has_many :private_messages, foreign_key: "to_id", class_name: "Message", dependent: :delete_all
  
  before_save { |user| user.email = email.downcase }
  before_save { |user| user.name = name.downcase }
  before_save :create_remember_token

  VALID_REALNAME = /\A([a-zA-Z]*\s+[a-zA-Z]*)\Z/i
  validates :realname, presence: true, 
                    length: { minimum: 2, maximum: 20 },
                    format: { with: VALID_REALNAME },
                    uniqueness: { case_sensitive: false }

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  VALID_USERNAME = /\A[a-z\d_]*\Z/i
  validates :name, presence: true, 
                    length: { minimum: 5, maximum: 15 },
                    format: { with: VALID_USERNAME }, 
                    uniqueness: { case_sensitive: false }

  validates :location, length: { maximum: 50 }
  validates :bio, length: { maximum: 255 }

  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

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
    opinions.find_by_like_id(random_share.id)
  end

  def like!(random_share)
    opinions.create!(like_id: random_share.id)
  end

  def unlike!(random_share)
    opinions.find_by_like_id(random_share.id).destroy
  end

  def to_param
    name
  end

protected

    def create_remember_token
      self.remember_token = SecureRandom.uuid
    end
end
