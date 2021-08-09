class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  validate :last_message, on: :update

  def last_message
    last_message_id = chat.messages
                          .where(user_id: user.id)
                          .order(updated_at: :desc)
                          .first
                          .id
    errors.add(:message, 'Can only edit last message') unless id == last_message_id
  end
end
