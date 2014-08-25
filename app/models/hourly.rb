class Hourly < ActiveRecord::Base
  belongs_to :ref_datum

  ## enable this for pagination: default_scope ->{ order('published_at') }
  scope :get_ref_datum_hourlies, ->(ref_datum_id) { where("ref_datum_id = ?", ref_datum_id).order('hour desc')}
  scope :distinct_hours, ->{pluck("distinct to_char(hour, 'YYYY-MM')")}
  scope :business_service_hourlies, ->(bus_id) { BusinessSystem.find(bus_id).hourlies }
  scope :during_year_and_month, ->(date) { where("to_char(hour, 'YYYY-mm') = ?", date)}
  scope :between_dates, ->(start_date,end_date) { where("hour between ? AND ?", start_date, end_date)}

end
