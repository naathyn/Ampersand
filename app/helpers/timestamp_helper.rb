module TimestampHelper
  def timestamp
    self.created_at.to_s( :long_ordinal ).gsub(/\d+:\d+/, '')
  end
end
