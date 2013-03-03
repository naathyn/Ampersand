class Opinion < ActiveRecord::Base
  attr_accessible :like_id

  belongs_to :fan, class_name: "User"
  belongs_to :like, class_name: "Micropost", counter_cache: :like_count

  validates_presence_of :fan_id, :like_id
end
