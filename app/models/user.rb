class User < ActiveRecord::Base 
  attr_accessible :realname, :email, :name, :location, :bio, :password, :password_confirmation

	has_secure_password

  has_many :microposts, dependent: :destroy
	has_many :replies, foreign_key: "to_id", class_name: "Micropost", dependent: :destroy

	has_many :opinions, foreign_key: "fan_id", dependent: :destroy
  has_many :fans, through: :opinions

	has_many :messages
	has_many :convos, foreign_key: "to_id", class_name: "Message"
  has_many :read_messages, foreign_key: "read_id", class_name: "Message"

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
  																	class_name: "Relationship",
																		dependent: :destroy
  has_many :followers, through: :reverse_relationships
  
  before_save { |user| user.email = email.downcase }
	before_save { |user| user.name = name.downcase }
  before_save :create_remember_token

	VALID_REALNAME = /\A([a-zA-Z]{2,20}\s+[a-zA-Z]{2,20})\Z/i
	validates :realname, presence: true, 
                    length: { minimum: 2, maximum: 20 },
                    format: { with: VALID_REALNAME },
										uniqueness: { case_sensitive: false }

	VALID_EMAIL = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :email, presence: true, format: { with: VALID_EMAIL },
                    uniqueness: { case_sensitive: false }

	VALID_USERNAME = /\A[a-z\d_.]{5,15}\Z/i
  validates :name, presence: true, 
                    length: { minimum: 5, maximum: 15 },
                    format: { with: VALID_USERNAME }, 
										uniqueness: { case_sensitive: false }

	validates :location, length: { maximum: 50 }
	validates :bio, length: { maximum: 255 }

  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

	def profile
		Micropost.from_users_profile(self)
	end

  def atreply
    Micropost.from_users_replies(self)
  end

  def share
    Micropost.from_users_shares(self)
  end

  def inbox
    Message.from_users_inbox(self)
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

  def user_names
   name.gsub(/ /,"_")
  end

  def self.regex_to_name(user_names)
   user_names.gsub(/ /," ")
  end

  def self.find_by_regex(user_names)
		users = where(name: User.regex_to_name(user_names))
    users.first
	end

protected

  def create_remember_token
    self.remember_token = SecureRandom.uuid
  end
end
