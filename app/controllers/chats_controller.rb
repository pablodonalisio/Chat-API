class ChatsController < ApplicationController
  def create
    chat = Chat.new(chat_params)
    if chat.save
      render json: chat, status: :created
    else
      render json: chat.errors, status: :bad_request
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:user_1_id, :user_2_id)
  end
end
