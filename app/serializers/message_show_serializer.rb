class MessageShowSerializer < ActiveModel::Serializer
  attributes :id, :body, :chat_id, :user_id, :created_at, :updated_at, :modified, :censored
  attributes :polarity
end
