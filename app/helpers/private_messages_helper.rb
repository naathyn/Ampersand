module PrivateMessagesHelper
  def message_time(time)
    DateTime.parse(time.to_s).strftime("%B %e at %l:%M %p")
  end

  def timestamp
    message_time(created_at)
  end

  def read_on
    message_time(read_at)
  end

  def message_read?
    self.read_at.nil? ? false : true
  end
end
