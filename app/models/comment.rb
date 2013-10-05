class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :blog, touch: true, counter_cache: :comment_count

  validates_presence_of :user_id, :blog_id, :content

  default_scope -> { order('created_at DESC') }

  per_page = 10
end
