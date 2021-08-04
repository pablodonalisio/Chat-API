class Chat < ApplicationRecord
  validates :user_1_id, presence: true
  validates :user_2_id, presence: true
end
