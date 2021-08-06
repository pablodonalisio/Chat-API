class ChatsController < ApplicationController
  def create
    chat = Chat.new
    user_2 = User.find(params[:user_id])
    chat.users << [@current_user, user_2]
    if chat.save
      render json: chat, status: :created
    else
      render json: chat.errors, status: :bad_request
    end
  end
end
