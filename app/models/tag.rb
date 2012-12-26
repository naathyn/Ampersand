class Tag < ActiveRecord::Base

  belongs_to :micropost
  belongs_to :hashtag

  validates_presence_of :micropost_id, :hashtag_id
end
