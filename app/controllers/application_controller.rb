class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_user_can_edit?

  def current_user_can_edit?(course)
    current_user.admin? || course.creator == current_user
  end

  def reject_user
    redirect_to root_path, alert: 'Access denied!'
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:update, keys: [:first_name, :last_name])
  end
end
