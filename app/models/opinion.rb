class Opinion < ActiveRecord::Base
  has_paper_trail :on => [:create]

	attr_accessible :fan_id, :like_id

	belongs_to :fan, class_name: "User"
	belongs_to :like, class_name: "Micropost"

	validates :fan_id, presence: true
	validates :like_id, presence: true
end
