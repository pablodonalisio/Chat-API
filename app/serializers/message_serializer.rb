class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :chat_id, :user_id
end
