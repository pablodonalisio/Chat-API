class MessagesController < ApplicationController
  before_action :set_message, only: [:update]
  before_action :authorize, only: [:update]

  def index
    messages = chat.messages.order(updated_at: :desc)
    render json: messages, status: :ok
  end

  def update
    if @message.update(message_params)
      render json: @message, status: :ok
    else
      render json: @message.errors, status: :bad_request
    end
  end

  private

  def chat
    @chat ||= Chat.find(params[:chat_id])
  end

  def set_message
    @message ||= Message.find_by(id: params[:id])
    render json: { error: "Couldn't find message" }, status: :bad_request if @message.nil?
  end

  def authorize
    error = { error: 'Not authorized'}
    render json: error, status: :forbidden unless @message.user == @current_user
  end
end
