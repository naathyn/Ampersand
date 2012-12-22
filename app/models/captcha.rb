class Captcha < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 5, maximum: 250 }
end

