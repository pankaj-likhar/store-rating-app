class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :address])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :address])
  end
  
  def authorize_admin
    redirect_to root_path, alert: "Not authorized" unless current_user && current_user.system_admin?
  end

   def after_sign_in_path_for(resource)
    if resource.system_admin?
      admin_dashboard_path
    else
      super
    end
  end

end
