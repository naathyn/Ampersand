class Blog < ActiveRecord::Base
  include AttachmentsHelper
  attr_accessible :title, :content, :tag_names, :photo
  attr_writer :tag_names

  HTML_TAGS = /<(?:([a-zA-Z\?][\w:\-]*)(\s(?:\s*[a-zA-Z][\w:\-]*(?:\s*=(?:\s*"(?:\\"|[^"])*"|\s*'(?:\\'|[^'])*'|[^\s>]+))?)*)?(\s*[\/\?]?)|\/([a-zA-Z][\w:\-]*)\s*|!--((?:[^\-]|-(?!->))*)--|!\[CDATA\[((?:[^\]]|\](?!\]>))*)\]\])>/

  belongs_to :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :comments, dependent: :destroy

  validates_presence_of :user_id, :title, :content
  validates_length_of :title, maximum: 50
  validates_format_of :extension, with: %r{(gif|jpg|png)$}i,
    allow_nil: true, allow_blank: true,
    message: 'must be a GIF, JPG or PNG.'

  after_save :assign_tags, :store_photo

  def tag_names
    @tag_names || tags.map(&:name).sort.join(', ')
  end

  def timestamp
    created_at.to_s(:long_ordinal).gsub /\d+:\d+/, ''
  end

  def preview
    content.gsub HTML_TAGS, ' '
  end

private

  def assign_tags
    if @tag_names
      self.tags = @tag_names.split(/\,/).map { |name|
        Tag.find_or_create_by_name! name.downcase.strip
      }
    end
  end
  self.per_page = 5
end
