class Admin::CampusesController < Admin::BaseController
  before_action :set_campus, only: [:edit, :update, :destroy]

  def index
    @campuses = Campu.all.order(:name)
  end

  def new
    @campus = Campu.new
  end

  def create
    @campus = Campu.new(campus_params)
    if @campus.save
      redirect_to admin_campuses_path, notice: "Campus created successfully."
    else
      flash.now[:alert] = "Unable to create campus. Fix the errors below."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @campus.update(campus_params)
      redirect_to admin_campuses_path, notice: "Campus updated successfully."
    else
      flash.now[:alert] = "Unable to update campus. Fix the errors below."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @campus.destroy
    redirect_to admin_campuses_path, notice: "Campus deleted."
  end

  private

  def set_campus
    @campus = Campu.find(params[:id])
  end

  def campus_params
    params.require(:campu).permit(:name, :address, :phone, :email, :principal_name)
  end
end
