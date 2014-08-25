class ManagementinfoController < ApplicationController

  def index
    @unique_dates = Hourly.distinct_hours
    #@unique_business_service = Event.unique_business_service(@unique_dates.first)
    @unique_business_service = BusinessSystem.all

    ##get the report data from the url parameter, if it blank try to default to the latest one
    if requested_date = params[:date]
      year=requested_date.split('-')[0]
      month=requested_date.split('-')[1]
    elsif @unique_dates.first
      year=@unique_dates.first.split('-')[0]
      month=@unique_dates.first.split('-')[1]
    end

    ### we need the month, year and ref_datum_id
    @management_information=[]
    if year && month
      @unique_business_service.each do |bs|
        @management_information << MIInformation.new( bs.id, month, year, bs.metric_id, bs.current_sla_kpi, bs.target)
      end
      ##periods, this needs to be moved to a helper
puts "CHRIS: #{year} #{month}"
      @periods = @management_information[0].periods
    end 
  end
end
