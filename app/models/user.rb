class User < ApplicationRecord
  validates_presence_of :first_name, :last_name, :email, :password
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, uniqueness: true

  has_many :chat_users
  has_many :chats, through: :chat_users
  has_many :messages

  enum settings: {
    all_upcase: 'all_upcase',
    all_downcase: 'all_downcase',
    no_accent_marks: 'no_accent_marks'
  }, _suffix: true
end
