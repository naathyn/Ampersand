class Tag < ActiveRecord::Base
  attr_accessible :micropost_id, :tag_id

  belongs_to :micropost
  belongs_to :tag

  validates_presence_of :micropost_id, :tag_id
end
