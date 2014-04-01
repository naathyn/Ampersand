json.array!(@private_messages) do |private_message|
  json.extract! private_message, :id, :sender_id, :recipient_id, :content, :read_at
  json.url private_message_url(private_message, format: :json)
end
