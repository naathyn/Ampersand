class Message < ActiveRecord::Base
  # attr_accessible :content

  belongs_to :user
  belongs_to :to, class_name: "User"

  validates_presence_of :user_id, :content
  validates_length_of :content, maximum: 500

  default_scope -> { order('created_at DESC') }

  per_page = 15
end
