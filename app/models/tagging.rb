class Tagging < ActiveRecord::Base
  belongs_to :blog
  belongs_to :tag, counter_cache: :tagging_count
  validates_presence_of :blog_id, :tag_id
end
