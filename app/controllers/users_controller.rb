class UsersController < ApplicationController
  skip_before_action :set_current_user, only: [:create]

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :bad_request
    end
  end

  def index
    @users = User.where.not(id: @current_user.id)
    render json: @users, fields: %i[id name]
  end

  def show
    user = User.find(params[:id])
    render json: user, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
