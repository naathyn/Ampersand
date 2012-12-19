class Hashtag < ActiveRecord::Base
	attr_accessible :name

  has_many :hashtags, dependent: :destroy  
  has_many :microposts, through: :hashtags 
end
