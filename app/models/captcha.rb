class Captcha < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 180 }

private

    def self.from_users_captchas(user)
      users_captchas = "SELECT followed_id FROM relationships 
                        WHERE follower_id = :user_id"
      captcha_ids = where("user_id IN (#{users_captchas})
                        OR user_id = :user_id", user_id: user.id)
      find(captcha_ids[rand(captcha_ids.length)]["id"].to_i)
    end
end
