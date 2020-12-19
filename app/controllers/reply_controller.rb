class ReplyController < ApplicationController
  before_action :authorize_request
  before_action :find_user, except: :reply

  # GET /read
  def read
    # get the receiver id
    @helper = MessageHelper.new
    idreceiver = @helper.getid(current_user.username)

    # update the read time
    @read = Message.includes(:conversation).where(conversations: { receiver: idreceiver.id })
    @read.update(read: Time.now)

    @message = Message.includes(:conversation)
                      .where(conversations: { receiver: idreceiver.id })
    @pagy, @records = pagy(@message, page: params[:page], items: 3)
    render json: { messages: @records, pagination:@pagy }, status: :ok
  end

  # POST /reply
  def reply
    # message helper
    @helper = MessageHelper.new
    checkreceiver = @helper.checkreceiver(current_user.username, params[:receiver])
    idreceiver = @helper.getid(params[:receiver])
    idsender = @helper.getid(current_user.username)
    check = @helper.isvalid(params[:message], params[:receiver])

    # reply helper
    @replyhelper = ReplyHelper.new
    is_read = @replyhelper.isread(current_user.username)
    hadchat = @replyhelper.havechat(idreceiver, idsender)

    # validation input
    if check
      return render json: { errors: check }, status: :unprocessable_entity
    end

    # receiver validation
    if idreceiver.nil?
      return render json: { errors: 'User not found' }, status: :not_found
    elsif checkreceiver
      return render json: { errors: 'Can\'t talk to self' }, status: :bad_request
    elsif hadchat.any? == false
      return render json: { errors: 'You haven\'t chat with this user before, can\'t reply' }, status: :not_found
    end

    # check whether the message are read or not
    unless is_read
      return render json: { errors: 'You have unread message, read it first' }, status: :forbidden
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
      render json: { conversation: @conv, message: @message }, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  private

  def find_user
    @user = User.find_by!(username: current_user.username)
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: not_found
  end
end
