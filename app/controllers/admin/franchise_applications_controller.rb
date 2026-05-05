class Admin::FranchiseApplicationsController < Admin::BaseController
  before_action :set_application, only: [ :show, :update ]
  before_action :authorize_application

  def index
    @applications = policy_scope(FranchiseApplication).includes(:franchise_payment).order(created_at: :desc)
    authorize FranchiseApplication

    @total_count = @applications.count
    @pending_payment_count = @applications.pending_payment.count
    @payment_received_count = @applications.payment_received.count
    @approved_count = @applications.approved.count
  end

  def show
  end

  def update
    old_status = @application.status
    if @application.update(status: params[:status])
      if @application.status != old_status
        if @application.approved?
          FranchiseApplicationMailer.application_approved(@application).deliver_later
        elsif @application.rejected?
          FranchiseApplicationMailer.application_rejected(@application).deliver_later
        end
      end
      redirect_to admin_franchise_application_path(@application), notice: "Status updated successfully."
    else
      redirect_to admin_franchise_application_path(@application), alert: "Failed to update status."
    end
  end

  private

  def set_application
    @application = FranchiseApplication.find(params[:id])
  end

  def authorize_application
    authorize @application if @application
  end
end
