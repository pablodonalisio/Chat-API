class Message < ApplicationRecord
  include Censored

  belongs_to :user
  belongs_to :chat

  validate :last_message, on: :update
  before_save :check_polarity
  before_save :censor_message

  def last_message
    last_message_id = chat.messages
                          .where(user_id: user.id)
                          .order(updated_at: :desc)
                          .first
                          .id
    errors.add(:message, 'Can only edit last message') unless id == last_message_id
  end

  def censor_message
    original_message = String.new(body)
    CENSORED_WORDS.each do |word|
      body.gsub!(/#{word}/i) do
        charset = Array('!'..'.')
        Array.new(word.length) { charset.sample }.join
      end
    end
    self.censored = true if original_message != body
  end

  def check_polarity
    self.polarity = MessageSentimentAnalyst.call(body)
  end
end
