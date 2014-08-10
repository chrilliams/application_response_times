class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  # GET /events
  # GET /events.json
  def index
    ##@events = Event.all
    if numeric_filter?
      @events = Event.where("ref_datum_id = ?", params[:filter]).order(sort_column + " " + sort_direction).page(params[:page])
      @filter = RefDatum.find(params[:filter])
      #@graph_data = Event.where("ref_datum_id = ?", params[:filter]).order(sort_column + " " + sort_direction).limit(1000).pluck(:duration).to_s.html_safe
      @graph_data = Event.get_ref_datum_events(@filter.id).hourlybreakdown
    else
      @events = Event.order(sort_column + " " + sort_direction).page(params[:page])
      #@filter = 'All Events'
      @filter = RefDatum.new(description: 'All Events', code:'all')
      #@graph_data = Event.order(sort_column + " " + sort_direction).limit(1000).pluck(:duration).to_s.html_safe
      @graph_data = Event.hourlybreakdown
    end
    #@referenceData = RefDatum.where("code LIKE ? ESCAPE '\\'", '%\_01\_%')
    @referenceData = RefDatum.all

    #@graph_labels = "'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'".html_safe
    #@graph_data = 1000.times.map{ Random.rand(300) }.to_s.html_safe

  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :start_time, :finish_time, :duration, :system, :sub_system)
    end

    def sort_column
      Event.column_names.include?(params[:sort]) ? params[:sort] : 'start_time'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    end

    def numeric_filter?
      Integer(params[:filter]) != nil rescue false
    end
end
