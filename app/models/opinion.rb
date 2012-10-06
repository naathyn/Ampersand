class Opinion < ActiveRecord::Base
	attr_accessible :like_id

	belongs_to :fan, class_name: "User"
	belongs_to :like, class_name: "Micropost"

	validates :fan_id, presence: true
	validates :like_id, presence: true
end
