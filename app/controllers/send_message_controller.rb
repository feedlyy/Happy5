class SendMessageController < ApplicationController
  before_action :authorize_request

  # POST /send
  def send_messages
    @helper = MessageHelper.new
    check = @helper.isvalid(params[:message], params[:receiver])
    checkreceiver = @helper.checkreceiver(current_user.username, params[:receiver])
    idreceiver = @helper.getid(params[:receiver])
    idsender = @helper.getid(current_user.username)

    # validation input
    if check
      return render json: { errors: check }, status: :unprocessable_entity
    end

    # receiver validation
    if idreceiver.nil?
      return render json: { errors: 'User not found' }, status: :not_found
    elsif checkreceiver
      return render json: { errors: 'Can\'t talk to self' }, status: :bad_request
    end

    # store conversation
    @conv = Conversation.new(sender: current_user.id, receiver: idreceiver.id)
    unless @conv.save
      render json: @conv.errors, status: :unprocessable_entity
    end

    # store message
    @message = Message.new(message: params[:message],
                           user_id: idsender.id,
                           conversation_id: @conv.id,
                           sent: Time.now)
    if @message.save
      render json: {conversation: @conv, message: @message}, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end
end
