class Event < ActiveRecord::Base
  belongs_to :ref_datum

  scope :get_ref_datum_events, ->(ref_datum_id) { where("ref_datum_id = ?", ref_datum_id)}
  scope :get_business_service_events, ->(bus_id) { BusinessSystem.find(bus_id).events }
  scope :all_during_year_and_month, ->(date) { where("to_char(start_time, '%Y-%m)", date)}
  scope :all_between_dates, ->(start_date,end_date) { where("start_time between ? AND ?", start_date, end_date)}
  scope :hourlybreakdown, ->{ group("to_char(start_time, 'YYYY-MM-ddTHH:00')").count}

  def self.unique_dates
    Event.order("start_time desc").pluck( "to_char(start_time, 'YYYY-mm')" ).uniq
  end
  
  def self.unique_business_service(dateIn)
    Event.all_during_year_and_month(dateIn).pluck(:ref_datum_id).uniq
  end

end

