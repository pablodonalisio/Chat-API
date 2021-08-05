class ChatSerializer < ActiveModel::Serializer
  attributes :id

  has_many :users, serializer: UserIndexSerializer
end
