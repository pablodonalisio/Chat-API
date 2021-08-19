class ApplicationController < ActionController::API
  serialization_scope :view_context
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def current_user
    user_id = request.headers['Current-User-Id'].to_i
    @current_user ||= User.find(user_id)
  end

  def record_not_found(exception)
    render json: { error: exception.to_s.split(' with')[0] }, status: :not_found
  end
end
