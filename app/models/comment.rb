class Comment < ActiveRecord::Base
  attr_accessible :blog_id, :content

  belongs_to :user
  belongs_to :blog

  validates_presence_of :user_id, :blog_id, :content
  validates_length_of :content, minimum: 5

  default_scope order: 'created_at ASC'

private
  self.per_page = 10
end
