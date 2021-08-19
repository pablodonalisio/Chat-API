class MessageSerializer < ActiveModel::Serializer
  include ActiveSupport::Inflector
  attributes :id, :body, :chat_id, :user_id

  def body
    text = object.body
    return text.upcase if current_user.all_upcase_settings?
    return text.downcase if current_user.all_downcase_settings?
    return transliterate(text) if current_user.no_accent_marks_settings?

    text
  end
end
