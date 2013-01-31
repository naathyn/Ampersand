module TimestampHelper
  def timestamp
    timestamp = self.created_at.to_formatted_s(:long).gsub(/\d*:\d*/, '')
    month = timestamp.gsub(/[\d,   ]/, '')
    day = "#{timestamp.match(/\d{1}+/)}".to_i.ordinalize
    year = timestamp.match(/\d{4}/)
    "#{month} #{day}, #{year}"
  end
end
