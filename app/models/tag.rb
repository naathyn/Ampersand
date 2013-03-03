class Tag < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :blogs, through: :taggings

  default_scope order: 'tagging_count DESC'
end
