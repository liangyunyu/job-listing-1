class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def require_is_admin
    if !current_user.admin?
      # flash[:alert] = "你没有权限进行此操作！"
      # redirect_to root_path
      redirect_to root_path, alert: "你没有权限进行此操作！"
    end
  end

  protected

  def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: [:is_admin])
  end

end
