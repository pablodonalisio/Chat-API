class User < ApplicationRecord
  validates_presence_of :first_name, :last_name, :email, :password
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, uniqueness: true

  has_many :messages
end
