class Hashtag < ActiveRecord::Base
  attr_accessible :name

  has_many :tags, dependent: :destroy
  has_many :microposts, through: :tags
end
