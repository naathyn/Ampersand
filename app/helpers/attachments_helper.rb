module AttachmentsHelper

  ATTACHMENTS = File.join Rails.root, 'public', 'attachments'

  def photo= file_data
    unless file_data.blank?
      @file_data = file_data
      self.extension = file_data.original_filename.split('.').last.downcase
    end
  end

  def photo_filename
    File.join ATTACHMENTS, "#{id}.#{extension}"
  end

  def photo_path
    "/attachments/#{id}.#{extension}"
  end

  def has_photo?
    File.exists? photo_filename
  end

protected

  def store_photo
    if @file_data
      FileUtils.mkdir_p ATTACHMENTS unless File.directory? ATTACHMENTS
      File.open photo_filename, 'wb' do |f|
        f.write @file_data.read
      end
      @file_data = nil
    end
  end
end
