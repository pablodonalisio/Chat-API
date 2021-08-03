class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      response = { id: user.id, email: user.email, message: 'Succesfully created' }
      render json: response, status: :created
    else
      render json: user.errors
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
