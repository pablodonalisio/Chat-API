class MessagesController < ApplicationController
  before_action :user_is_in_chat
  before_action :authorize, only: [:update]

  def index
    messages = chat.messages.order(updated_at: :desc)
    render json: messages, status: :ok, scope: current_user, scope_name: :current_user
  end

  def create
    message = chat.messages.build(message_params)
    message.user = @current_user
    if message.save
      render json: message, status: :created
    else
      render json: message.errors, status: :bad_request
    end
  end

  def show
    render json: message, status: :ok, serializer: MessageShowSerializer
  end

  def update
    if message.update(body: message_params[:body], modified: true)
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

  def user_is_in_chat
    error = { error: "You don't have access to this chat" }
    render json: error, status: :forbidden unless chat.users.include?(@current_user)
  end

  def message
    @message ||= Message.find(params[:id])
  end

  def authorize
    error = { error: 'Not authorized' }
    render json: error, status: :forbidden unless message.user == current_user
  end
end
