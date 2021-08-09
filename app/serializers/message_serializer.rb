class MessageSerializer < ActiveModel::Serializer
  include ActiveSupport::Inflector
  attributes :id, :body, :chat_id, :user_id

  def body
    return object.body.upcase if @instance_options[:user_settings] == 'all_upcase'
    return object.body.downcase if @instance_options[:user_settings] == 'all_downcase'
    return transliterate(object.body) if @instance_options[:user_settings] == 'no_accent_marks'

    object.body
  end
end
