class ApplicationController < ActionController::API
  before_action :set_current_user

  private

  def set_current_user
    current_user_id = request.headers['Current-User-Id'].to_i
    @current_user = User.find(current_user_id)
  end
end
