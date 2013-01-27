class Tag < ActiveRecord::Base
  attr_accessible :name

  has_many :taggings, dependent: :destroy
  has_many :blogs, through: :taggings

  default_scope order: 'name'
end
