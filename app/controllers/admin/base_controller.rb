class Admin::BaseController < ApplicationController
  before_action :authenticate_admin_user!
  layout "admin"

  rescue_from ActiveRecord::RecordNotFound, with: :admin_record_not_found
  rescue_from ActionController::ParameterMissing, with: :admin_bad_request
  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to admin_root_path, alert: "Access denied. You don't have permission to perform this action."
  end

  private

  def admin_record_not_found(exception = nil)
    flash[:alert] = "The requested admin resource was not found."
    redirect_to admin_root_path
  end

  def admin_bad_request(exception = nil)
    flash[:alert] = "Invalid admin request. Please check your input and try again."
    redirect_to request.referrer || admin_root_path
  end

  def pundit_user
    current_admin_user
  end
end
