module TimestampHelper
  def timestamp
    timestamp = self.created_at.to_formatted_s(:long).gsub(/\d*:\d*/, '')
    day = "#{timestamp.match(/\d{1}+/)}".to_i.ordinalize
    month = timestamp.gsub(/[\d,]/, '')
    year = timestamp.match(/\d{4}/)
    "#{month} #{day}, #{year}"
  end
end
