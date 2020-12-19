class ListChatController < ApplicationController
  before_action :authorize_request

  def listchat
    @pagy, @records = pagy(Message.all, page: params[:page], items: 3)
    render json: { data: @records, pagination:@pagy }, status: :ok
  end
end
