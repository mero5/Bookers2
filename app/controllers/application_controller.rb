class ApplicationController < ActionController::Base
before_action :authenticate_user!, except: [:top]
before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  def after_sign_in_path_for(resource)
    flash[:notice] = "Welcome! You have signed up successfully."
    user = current_user
    user_path(user.id)
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "Signed out successfully."
    root_path
  end
end
