class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[index create]

  # GET /users
  def index
    @pagy, @records = pagy(User.all, page: params[:page], items: 3)
    render json: {data: @records}
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    @user.update(user_params)
    if @user.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def find_user
    @user = User.find_by!(id: params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: not_found
  end

    # Only allow a list of trusted parameters through.
  def user_params
    params.permit(:username, :password)
  end
end
