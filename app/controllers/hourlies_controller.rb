class HourliesController < ApplicationController
  before_action :set_hourly, only: [:show, :edit, :update, :destroy]

  # GET /hourlies
  # GET /hourlies.json
  def index
    params[:filter] ||= RefDatum.first.id.to_s
    params[:from] ||= DateTime.now.strftime("%Y-%m-%d")
    to = Date.parse(params[:from]).next_day(7).strftime("%Y-%m-%d")

    @hourlies = Hourly.get_ref_datum_hourlies(params[:filter]).between_dates(params[:from],to)
    @refDatum = RefDatum.all
    @filter = RefDatum.find(params[:filter])
  end

  # GET /hourlies/1
  # GET /hourlies/1.json
  def show
  end

  # GET /hourlies/new
  def new
    @hourly = Hourly.new
  end

  # GET /hourlies/1/edit
  def edit
  end

  # POST /hourlies
  # POST /hourlies.json
  def create
    @hourly = Hourly.new(hourly_params)

    respond_to do |format|
      if @hourly.save
        format.html { redirect_to @hourly, notice: 'Hourly was successfully created.' }
        format.json { render :show, status: :created, location: @hourly }
      else
        format.html { render :new }
        format.json { render json: @hourly.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hourlies/1
  # PATCH/PUT /hourlies/1.json
  def update
    respond_to do |format|
      if @hourly.update(hourly_params)
        format.html { redirect_to @hourly, notice: 'Hourly was successfully updated.' }
        format.json { render :show, status: :ok, location: @hourly }
      else
        format.html { render :edit }
        format.json { render json: @hourly.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hourlies/1
  # DELETE /hourlies/1.json
  def destroy
    @hourly.destroy
    respond_to do |format|
      format.html { redirect_to hourlies_url, notice: 'Hourly was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hourly
      @hourly = Hourly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hourly_params
      params.require(:hourly).permit(:hour, :maximum, :minimum, :average)
    end
end
