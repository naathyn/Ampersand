class Blog < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title_and_author, use: :slugged

  attr_writer :tag_names

  HTML_TAGS = /<(?:([a-zA-Z\?][\w:\-]*)(\s(?:\s*[a-zA-Z][\w:\-]*(?:\s*=(?:\s*"(?:\\"|[^"])*"|\s*'(?:\\'|[^'])*'|[^\s>]+))?)*)?(\s*[\/\?]?)|\/([a-zA-Z][\w:\-]*)\s*|!--((?:[^\-]|-(?!->))*)--|!\[CDATA\[((?:[^\]]|\](?!\]>))*)\]\])>/

  belongs_to :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :comments, dependent: :destroy

  validates_presence_of :user_id, :title, :content
  validates_length_of :title, maximum: 50

  before_save :assign_tags

  def tag_names
    @tag_names || tags.map(&:name).uniq.sort.join(', ')
  end

  def timestamp
    created_at.to_s(:long_ordinal).gsub(/\d+:\d+/, '')
  end

  def title_and_author
    "#{title} by #{user.realname}"
  end

  def preview
    content.gsub(HTML_TAGS, ' ')
  end

  def has_photo?
    photo.present?
  end

private

  per_page = 10

  def assign_tags
    if @tag_names
      self.tags = @tag_names.split(/\,/).map { |name|
        Tag.find_or_create_by!(name: name.downcase.strip)
      }.uniq
    end
  end
end
