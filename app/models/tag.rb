class Tag < ActiveRecord::Base
  attr_accessible :micropost_id, :hashtag_id

  belongs_to :micropost
  belongs_to :hashtag

  validates_presence_of :micropost_id, :hashtag_id
end
