class Blog < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title_and_author, use: :slugged

  attr_writer :tag_names

  DEFAULT_THUMB = '/assets/ampersand.jpg'

  HTML_TAGS = /<(?:([a-zA-Z\?][\w:\-]*)(\s(?:\s*[a-zA-Z][\w:\-]*(?:\s*=(?:\s*"(?:\\"|[^"])*"|\s*'(?:\\'|[^'])*'|[^\s>]+))?)*)?(\s*[\/\?]?)|\/([a-zA-Z][\w:\-]*)\s*|!--((?:[^\-]|-(?!->))*)--|!\[CDATA\[((?:[^\]]|\](?!\]>))*)\]\])>/

  belongs_to :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :comments, dependent: :destroy

  validates_presence_of :user_id, :title, :content

  validates_length_of :title, maximum: 50

  after_save :assign_tags

  def tag_names
    @tag_names || tags.map(&:name).sort.join(', ')
  end

  def timestamp
    created_at.to_s(:long_ordinal).gsub(/\d+:\d+/, '')
  end

  def preview
    content.gsub(HTML_TAGS, ' ')
  end

  def has_photo?
    photo.present?
  end

  def title_and_author
    "#{title} by #{user.realname}"
  end

  per_page = 10

private

  def assign_tags
    if @tag_names
      self.tags = @tag_names.split(/\,/).map { |name|
        Tag.find_or_create_by_name!(name.downcase.strip)
      }
    end
  end
end
