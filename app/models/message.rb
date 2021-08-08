class Message < ApplicationRecord
  include Censored

  belongs_to :user
  belongs_to :chat

  before_save :censor_message

  def censor_message
    CENSORED_WORDS.each do |word|
      body.gsub!(word) do
        charset = Array('!'..'.')
        Array.new(word.length) { charset.sample }.join
      end
    end
  end
end
