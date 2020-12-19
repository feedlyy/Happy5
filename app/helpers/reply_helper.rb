class ReplyHelper
  def isread(authuser)
    # get the receiver id
    @helper = MessageHelper.new
    idreceiver = @helper.getid(authuser)
    
    @message = Message.includes(:conversation).where(conversations: {receiver: idreceiver.id})
    @sorted = @message.sort_by { |a| a.sent }

    unless @sorted.last.read.nil?
      true
    end
  end

  def havechat(s, r)
    @conversations = Conversation.where(sender: s, receiver: r)
  end
end