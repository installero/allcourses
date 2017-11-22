class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user_can_edit?

  def current_user_can_edit?(course)
    current_user.admin? || course.creator == current_user
  end

  def reject_user
    redirect_to root_path, alert: 'Вам сюда низя!'
  end
end
