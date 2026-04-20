class Admin::CampuController < Admin::BaseController
  before_action :set_campu, only: [:edit, :update, :destroy]

  def index
    @campuses = Campu.all.order(:name)
  end

  def new
    @campu = Campu.new
  end

  def create
    @campu = Campu.new(campu_params)
    if @campu.save
      redirect_to admin_campu_index_path, notice: "Campus created successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @campu.update(campu_params)
      redirect_to admin_campu_index_path, notice: "Campus updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @campu.destroy
    redirect_to admin_campu_index_path, notice: "Campus deleted."
  end

  private

  def set_campu
    @campu = Campu.find(params[:id])
  end

  def campu_params
    params.require(:campu).permit(:name, :address, :phone, :email, :principal_name)
  end
end
