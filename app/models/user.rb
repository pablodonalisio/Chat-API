class User < ApplicationRecord
  validates_presence_of :firstName, :lastName, :email, :password
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, uniqueness: true
end
