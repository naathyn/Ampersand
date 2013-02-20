class Blog < ActiveRecord::Base
  include AttachmentsHelper

  attr_accessible :title, :content, :tag_names, :photo
  attr_writer :tag_names

  belongs_to :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates_presence_of :title, :content
  validates_format_of :extension, with: %r{(gif|jpg|png)$}i, allow_nil: true, allow_blank: true

  after_save :assign_tags, :store_photo
  
  default_scope order: 'created_at DESC'
  
  def tag_names
    @tag_names || tags.map(&:name).join(', ')
  end

  def timestamp
    self.created_at.to_s(:long_ordinal).gsub(/\d+:\d+/, '')
  end
  
private

  self.per_page = 5
  
  def assign_tags
    if @tag_names
      self.tags = @tag_names.split(/\,/).map do |name|
        Tag.find_or_create_by_name(name.gsub(/\s+/, '').downcase)
      end
    end
  end
end
