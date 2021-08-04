class Chat < ApplicationRecord
  validates :user_1_id, presence: true
  validates :user_2_id, presence: true
  validate :chat_exists, on: :create

  has_many :messages, dependent: :destroy

  def chat_exists
    chat = Chat.where(user_1_id: user_1_id, user_2_id: user_2_id)
               .or(Chat.where(user_1_id: user_2_id, user_2_id: user_1_id))
    errors.add(:chat, 'Already exists') if chat.any?
  end
end
