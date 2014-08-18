class MIInformation

  attr_accessor :business_service_id, :month, :year, :metric_id, :current_sla_kpi, :target
  attr_reader :business_service_name

  TIME_UNIT = 1000
  ROUND = 3

  def initialize(business_service_id, month, year, metric_id, current_sla_kpi, target)
    @business_service_id=business_service_id

    #  pull back all the business system information from the database
    @business_system=BusinessSystem.find(@business_service_id)
    @business_service_name=@business_system.business_service_name
#    @all_refdatum=RefDatum.find_by_business_system_id(@business_service_id).description
    @metric_id=@business_system.metric_id
    @current_sla_kpi=@business_system.current_sla_kpi
    @target=@business_system.target

    @month=month
    @year=year
    @start_date= Date.new(@year.to_i,@month.to_i, 1)
    @end_date= Date.new(@year.to_i,@month.to_i,-1)+1
  end

  def period_max (period_number)
    first_date = periods.unshift(@start_date)[period_number -1]
    last_date = periods.unshift(@start_date)[period_number]
    max=Event.get_business_service_events(@business_service_id).all_between_dates(first_date, last_date).order('duration DESC').first
    max.nil? ? '' : (max.duration.to_f / TIME_UNIT ).round(ROUND)
  end
  
  def period_hourly_max (period_number)
    first_date = periods.unshift(@start_date)[period_number -1]
    last_date = periods.unshift(@start_date)[period_number]
    max=Event.get_business_service_events(@business_service_id).all_between_dates(first_date, last_date).hourlybreakdown.values.max
    max.nil? ? '' : (max.to_f / TIME_UNIT ).round(ROUND)
  end


  def period_average (period_number)
    first_date = periods.unshift(@start_date)[period_number -1]
    last_date = periods.unshift(@start_date)[period_number]
    durations=Event.get_business_service_events(@business_service_id).all_between_dates(first_date, (last_date)).pluck(:duration)
    durations.size >0 ? (durations.sum.to_f / durations.size / TIME_UNIT).round(ROUND) : ''

  end

  def achieved?
    month_average.to_f < @target.to_f
  end

  def month_average
    durations=Event.get_business_service_events(@business_service_id).all_during_year_and_month(year_month).pluck(:duration)
    (durations.sum.to_f / durations.size / TIME_UNIT).round ROUND
  end

  def month_max
    Event.get_business_service_events(@business_service_id).all_during_year_and_month(year_month).order('duration DESC').first.duration.to_f  / TIME_UNIT
  end

  def periods
    #(sundays_in_the_month.delete_at(0)) << @end_date
    periods_array = sundays_in_the_month 
    if (periods_array.size >= 4)
      ## more than 4 periods plus the end date.  We have the remove one
      if ((periods_array[0] - @start_date) < 5)
        periods_array.delete_at(0)
        ## remove the first entry
      end
      if ((@end_date - periods_array[-1]) < 5)
      ## remove the last entry
        periods_array.delete_at(-1)
      end
    end
    periods_array << @end_date
  end

  def sundays_in_the_month
    ## sunday is actually the Monday.  This allows the sql between to work.  1 day is reviewed from the view
    sunday=1
    (@start_date..@end_date).select {|day| [sunday].include?(day.wday)}
  end 

## need to calculate period_1, period_2, period_3, period_4, monthly_average
private

  def year_month
    @year.to_s + '/' + @month.to_s
  end
end
