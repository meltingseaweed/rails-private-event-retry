class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Permit Username parameter for users
  protected
    def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username ])
    end

  # Require login before doing anything
  private
    def require_login
      if user_signed_in? == false
        flash[:notice] = "You must be logged in to access that page"
        redirect_to new_user_session_path
      end
    end
end
