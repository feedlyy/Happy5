class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  # def checkPwd
  #   @user = User.select(:password_digest).where(username: params[:username])
  #
  #   puts @user.to_s
  # end

  # POST auth/login
  def login
    @user = User.find_by(username: params[:username])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 1.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     username: @user.username}, status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:username, :password)
  end
end