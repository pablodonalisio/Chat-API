class MessagesController < ApplicationController
  def index
    messages = chat.messages.order(updated_at: :desc)
    render json: messages, status: :ok
  end

  private

  def chat
    @chat ||= Chat.find(params[:chat_id])
  end
end
