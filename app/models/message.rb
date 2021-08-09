class Message < ApplicationRecord
  include Censored

  belongs_to :user
  belongs_to :chat

  before_save :censor_message
  validate :last_message, on: :update

  def censor_message
    CENSORED_WORDS.each do |word|
      body.gsub!(word) do
        charset = Array('!'..'.')
        Array.new(word.length) { charset.sample }.join
      end
    end
  end

  def last_message
    last_message_id = chat.messages
                          .where(user_id: user.id)
                          .order(updated_at: :desc)
                          .first
                          .id
    errors.add(:message, 'Can only edit last message') unless id == last_message_id
  end
end
