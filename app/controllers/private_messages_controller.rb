class PrivateMessagesController < ApplicationController

  before_filter :signed_in_user
  before_filter :correct_user
  before_action :set_user

  def index
    @inbox = params[:mailbox] || "inbox"

    if @inbox == "sent"
      @mailbox = "Sent Messages"
      @messages = current_user.outbox.page(params[:page])
    elsif @inbox == "trash"
      @mailbox = "Trash"
      @messages = current_user.trash.page(params[:page])
    else
      @messages = current_user.inbox.page(params[:page])
      @mailbox = "Inbox"
    end
    @size ||= @messages.size
    render :inbox
  end

  def show
    @private_message = current_user.read!(params[:id])
    @sender = @private_message.sender
    @recipient = @private_message.recipient
  end

  def new
    @message = PrivateMessage.new

    if params[:reply_to]
      @reply_to = current_user.inbox.find(params[:reply_to])
      unless @reply_to.nil?
        @message.to = @reply_to.sender.username
        @message.content =
          "<br><br><h3>On #{@reply_to.timestamp},
            <b>#{@reply_to.sender.realname}</b> wrote:</h3>
            <blockquote><i> #{@reply_to.content}</i></blockquote>"
      end
    end
  end

  def create
    @message = PrivateMessage.new(private_message_params)
    @message.sender = current_user
    @message.recipient = User.find_by_name(params[:private_message][:to].gsub(/@/, ''))
    if @message.save
      flash[:success] = "Message was delivered to #{@message.recipient.realname}"
      redirect_to user_private_messages_path(current_user)
    else
      render :new
    end
  end

  def delete_selected
    if request.post?
      if params[:delete]
        params[:delete].each { |message|
          current_user.delete!(message) unless message.nil?
        }
        flash[:notice] = params[:mailbox] == "trash" ?
          "Your selected messages have been restored" :
          "You're selected messages have been archived"
      end
      flash[:danger] = "There must be something marked
                        before you can take this action!" if params[:delete].nil?
      redirect_to :back
    end
  end

  private

    def private_message_params
      params.require(:private_message).permit(:sender_id, :recipient_id, :content)
    end

    def set_user
      @user = User.friendly.find(params[:user_id])
    end

    def correct_user
      set_user
      redirect_to user_private_messages_path(current_user), notice:
        "You may only view your own inbox" unless current_user?(@user)
    end
end
