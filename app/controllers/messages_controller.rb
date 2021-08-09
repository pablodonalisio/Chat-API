class MessagesController < ApplicationController
  before_action :authorize, only: [:update]

  def index
    messages = chat.messages.order(updated_at: :desc)
    render json: messages, status: :ok
  end

  def show
    render json: message, status: :ok, serializer: MessageShowSerializer
  end

  def update
    if message.update(message_params)
      render json: message, status: :ok
    else
      render json: message.errors, status: :bad_request
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def chat
    @chat ||= Chat.find(params[:chat_id])
  end

  def message
    @message ||= Message.find(params[:id])
  end

  def authorize
    error = { error: 'Not authorized' }
    render json: error, status: :forbidden unless message.user == @current_user
  end
end
