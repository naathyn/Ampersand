class Opinion < ActiveRecord::Base
	attr_accessible :fan_id, :like_id

	belongs_to :fan, class_name: "User"
	belongs_to :like, class_name: "Micropost"

  has_paper_trail :on => [:create]

	validates :fan_id, presence: true
	validates :like_id, presence: true
end
