class Tag < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :blogs, through: :taggings, include: [:tags, :user]

  default_scope order: 'tagging_count DESC'
  private; self.per_page = 50
end
