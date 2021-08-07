class MessagesController < ApplicationController
  def index
    messages = chat.messages.order(updated_at: :desc)
    render json: messages, status: :ok
  end

  def show
    render json: message, status: :ok, serializer: MessageShowSerializer
  end

  private

  def chat
    @chat ||= Chat.find(params[:chat_id])
  end

  def message
    @message ||= Message.find(params[:id])
  end
end
