class Blog < ActiveRecord::Base
  attr_accessible :title, :content, :tag_names, :photo
  attr_writer :tag_names

  belongs_to :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  BLOG_ATTACHMENTS = File.join Rails.root, 'public', 'attachments'

  validates_presence_of :title, :content
  validates_format_of :extension, with: %r{(gif|jpg|png)$}i, allow_nil: true, allow_blank: true

  after_save :assign_tags, :store_photo
  
  default_scope order: 'created_at DESC'
  
  def tag_names
    @tag_names || tags.map(&:name).join(', ')
  end

  def photo=(file_data)
    unless file_data.blank?
      @file_data = file_data
      self.extension = file_data.original_filename.split('.').last.downcase
    end
  end

  def photo_filename
    File.join BLOG_ATTACHMENTS, "#{id}.#{extension}"
  end

  def photo_path
    "/attachments/#{id}.#{extension}"
  end

  def has_photo?
    File.exists? photo_filename
  end

  def tag_placeholder
    "untagged" if tag_names.empty?
  end
  
private
  
  def assign_tags
    if @tag_names
      self.tags = @tag_names.split(/\,/).map do |name|
        Tag.find_or_create_by_name(name.gsub(/\s+/, '').downcase)
      end
    end
  end

  def store_photo
    if @file_data
      FileUtils.mkdir_p BLOG_ATTACHMENTS
      File.open(photo_filename, 'wb') do |f|
        f.write(@file_data.read)
      end
      @file_data = nil
    end
  end
end
