class BusinessSystemsController < ApplicationController
  before_action :set_business_system, only: [:show, :edit, :update, :destroy]
  #after_action :create_nested, only: [:new, :edit]

  # GET /business_systems
  # GET /business_systems.json
  def index
    @business_systems = BusinessSystem.all
  end

  # GET /business_systems/1
  # GET /business_systems/1.json
  def show
  end

  # GET /business_systems/new
  def new
    @business_system = BusinessSystem.new
    #@business_system.ref_datum.build if @business_system.ref_datum.size = 0 
    #@business_system.log_file.build
    create_nested @business_system


  end

  # GET /business_systems/1/edit
  def edit
    if !@business_system.log_file.exists?
      @business_system.log_file.build 
    end
  end

  # POST /business_systems
  # POST /business_systems.json
  def create
    @business_system = BusinessSystem.new(business_system_params)

    respond_to do |format|
      if @business_system.save
        format.html { redirect_to business_systems_url, notice: 'Success Save' }
        format.json { render :show, status: :created, location: @business_system }
      else
        create_nested @business_system
        format.html { render :new }
        format.json { render json: @business_system.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /business_systems/1
  # PATCH/PUT /business_systems/1.json
  def update
    respond_to do |format|
      if @business_system.update(business_system_params)
        format.html { redirect_to business_systems_url, notice: 'Success Update' }
        format.json { render :show, status: :ok, location: @business_system }
      else
        create_nested @business_system
        format.html { render :edit }
        format.json { render json: @business_system.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /business_systems/1
  # DELETE /business_systems/1.json
  def destroy
    @business_system.destroy
    respond_to do |format|
      format.html { redirect_to business_systems_url, notice: 'Business system was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_business_system
      @business_system = BusinessSystem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_system_params
      params.require(:business_system).permit(:business_service_name, :metric_id, :current_sla_kpi, :target, ref_datum_attributes: [:id, :code, :description, :_destroy], log_file_attributes: [:id, :file_name, :line_format, :fields])
    end


    def create_nested ( bs )
      #bs.ref_datum.build if @business_system.ref_datum.size = 0
      bs.ref_datum.build if @business_system.ref_datum.size == 0
      bs.log_file.build if @business_system.log_file.size == 0
    end
end
