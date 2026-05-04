class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :bad_request

  private

  def record_not_found(exception = nil)
    flash[:alert] = t("flash.common.not_found")
    redirect_to root_path
  end

  def bad_request(exception = nil)
    flash[:alert] = t("flash.common.invalid_request")
    redirect_to request.referrer || root_path
  end

  def user_not_authorized
    redirect_to root_path, alert: t("flash.common.not_authorized")
  end
end
