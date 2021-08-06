class MessagesController < ApplicationController
  before_action :set_chat
  before_action :user_is_in_chat

  def index
    messages = @chat.messages.order(updated_at: :desc)
    render json: messages, status: :ok
  end

  def create
    message = @chat.messages.build(message_params)
    message.user = @current_user
    if message.save
      render json: message, status: :created
    else
      render json: message.errors, status: :bad_request
    end
  end

  private

  def set_chat
    @chat ||= Chat.find_by(id: params[:chat_id])
    render json: { error: "Couldn't find chat" }, status: :bad_request if @chat.nil?
  end

  def message_params
    params.require(:message).permit(:body)
  end

  def user_is_in_chat
    error = { error: "You don't have access to this chat" }
    render json: error, status: :forbidden unless @chat.users.include?(@current_user)
  end
end
