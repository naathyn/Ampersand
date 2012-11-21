class Captcha < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 180 }

  default_scope order: 'captchas.created_at DESC'

private

  def self.random
    ids = connection.select_all("SELECT id FROM captchas")
    find(ids[rand(ids.length)]["id"].to_i) unless ids.blank?
  end
end
