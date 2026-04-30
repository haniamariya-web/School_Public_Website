# app/controllers/admin/campu_controller.rb
class Admin::CampuController < Admin::BaseController
  before_action :set_campus, only: [:edit, :update, :destroy]
  before_action :authorize_campus

  def index
    @campuses = policy_scope(Campu).order(:name)
    authorize Campu  # ✅ Changed from Campu to Campu (it's correct, but check case)
  end

  def new
    authorize Campu  # ✅ Changed
    @campus = Campu.new
  end

  def create
    authorize Campu  # ✅ Changed
    @campus = Campu.new(campus_params)
    if @campus.save
      redirect_to admin_campu_index_path, notice: "Campus created successfully."
    else
      flash.now[:alert] = "Unable to create campus. Fix the errors below."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @campus  # ✅ Add this line
  end

  def update
    authorize @campus  # ✅ Add this line
    if @campus.update(campus_params)
      redirect_to admin_campu_index_path, notice: "Campus updated successfully."
    else
      flash.now[:alert] = "Unable to update campus. Fix the errors below."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @campus  # ✅ Add this line
    @campus.destroy
    redirect_to admin_campu_index_path, notice: "Campus deleted."
  end

  private

  def set_campus
    @campus = Campu.find(params[:id])
  end

  def authorize_campus
    authorize @campus if @campus
  end

  def campus_params
    params.require(:campu).permit(:name, :address, :phone, :email, :principal_name)
  end
end