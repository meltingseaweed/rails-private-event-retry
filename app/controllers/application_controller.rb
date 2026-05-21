class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  # Require login before doing anything

  private
  def require_login
    if user_signed_in? == false
      flash[:notice] = "You must be logged in to access that page"
      redirect_to new_user_session_path
    end
  end
end
