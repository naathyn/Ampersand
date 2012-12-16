class Captcha < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 5, maximum: 250 }

private

  def self.from_random_user_captcha_ids(user)
    captcha_user_ids = where(user_id: user.id)
    find(captcha_user_ids[rand(captcha_user_ids.length)]["id"].to_i) unless captcha_user_ids.blank?
  end
end

