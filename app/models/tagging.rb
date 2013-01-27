class Tagging < ActiveRecord::Base
  belongs_to :blog
  belongs_to :tag

  validates_presence_of :blog_id, :tag_id
end
