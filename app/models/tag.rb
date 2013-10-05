class Tag < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :taggings, dependent: :destroy
  has_many :blogs, through: :taggings

  default_scope -> { order('tagging_count DESC') }
end
