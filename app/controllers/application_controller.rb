class ApplicationController < ActionController::API
  before_action :set_current_user
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def set_current_user
    current_user_id = request.headers['Current-User-Id'].to_i
    @current_user = User.find(current_user_id)
  end

  def record_not_found(exception)
    render json: { error: exception.to_s.split(' with')[0] }, status: :not_found
  end
end
