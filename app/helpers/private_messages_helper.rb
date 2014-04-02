module PrivateMessagesHelper
  def link_to_message_sender(message, sender)
    if sender == message.sender
      link = "You"
    else
      sender = message.sender
      link = sender.realname
    end
    link_to(link, sender)
  end

  def link_to_message_recipient(message, recipient)
    if recipient == message.recipient
      link = "You"
    else
      recipient = message.recipient
      link = recipient.realname
    end
    link_to(link, recipient)
  end
end
