class RefDataController < ApplicationController
  before_action :set_ref_datum, only: [:show, :edit, :update, :destroy]

  # GET /ref_data
  # GET /ref_data.json
  def index
    @ref_data = RefDatum.all
  end

  # GET /ref_data/1
  # GET /ref_data/1.json
  def show
  end

  # GET /ref_data/new
  def new
    @ref_datum = RefDatum.new
  end

  # GET /ref_data/1/edit
  def edit
  end

  # POST /ref_data
  # POST /ref_data.json
  def create
    @ref_datum = RefDatum.new(ref_datum_params)

    respond_to do |format|
      if @ref_datum.save
        format.html { redirect_to @ref_datum, notice: 'Ref datum was successfully created.' }
        format.json { render :show, status: :created, location: @ref_datum }
      else
        format.html { render :new }
        format.json { render json: @ref_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ref_data/1
  # PATCH/PUT /ref_data/1.json
  def update
    respond_to do |format|
      if @ref_datum.update(ref_datum_params)
        format.html { redirect_to @ref_datum, notice: 'Ref datum was successfully updated.' }
        format.json { render :show, status: :ok, location: @ref_datum }
      else
        format.html { render :edit }
        format.json { render json: @ref_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ref_data/1
  # DELETE /ref_data/1.json
  def destroy
    @ref_datum.destroy
    respond_to do |format|
      format.html { redirect_to ref_data_url, notice: 'Ref datum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ref_datum
      @ref_datum = RefDatum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ref_datum_params
      params.require(:ref_datum).permit(:code, :description)
    end
end
